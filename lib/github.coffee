$ = require 'jquery'
Issue = require './models/Issue'

module.exports =
  getRepository: ->
    new Promise (resolve, reject) ->
      project = atom.project
      path = atom.workspace.getActiveTextEditor()?.getPath()
      directory = project.getDirectories().filter((d) -> d.contains(path))[0]
      if directory?
        project.repositoryForDirectory(directory).then (repo) ->
          match = repo.getOriginURL().match(///git@github\.com:([^/]*)\/([^.]*)\.git///)
          if match?
            [repo.username, repo.reponame] = match[1..2]
            resolve(repo)
          match = repo.getOriginURL().match(///https:\/\/github\.com\/([^/]*)\/([^.]*)///)
          if match?
            [repo.username, repo.reponame] = match[1..2]
            resolve(repo)
          reject "not a github repository"
        .catch (e) ->
          reject(e)
      else
        reject "no current file"
  loadIssues: (repo)->
    $.ajax({
      url: "https://api.github.com/repos/#{repo.username}/#{repo.reponame}/issues",
      dataType: "json",
      method: "GET",
      username: repo.username,
      password: atom.config.get 'github-plus.privateAccessToken'
    }).then (data)->
      new Issue(repo, issue) for issue in data
  loadComment: (issue)->
    $.ajax(
      url: issue.comments_url
      method: 'GET'
      dataType: 'json'
      username: issue.repo.username
      password: atom.config.get 'github-plus.privateAccessToken'
    ).then (data) ->
      issue.comments = data
      issue.lazy.comment = false
      issue
