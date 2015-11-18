$ = require 'jquery'

module.exports =
class Issue
  constructor: (repo, githubIssue)->
    this[key] = value for key, value of githubIssue
    this.repo = repo
    this.lazy =
      comment: true
  loadComment: ->
    Github = require '../github'
    Github.loadComment(this)
