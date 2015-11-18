IssueListView = require './views/IssueList'
Github = require './github'

atom.workspace.addOpener (uri) ->
  return new IssueListView if uri is "atom://github-plus:list-issues"

module.exports =
  commandList: ->
    Github.getRepository().then (repo) ->
      atom.workspace.open("atom://github-plus:list-issues", {split: 'right'}).then (view)->
        view.clear()
        Github.loadIssues(repo).then (issues)->
          view.addIssue(issue) for issue in issues
