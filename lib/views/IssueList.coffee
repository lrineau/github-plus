{$,$$,View} = require 'space-pen'

module.exports =
class IssueListView extends View
  @content: ->
    @div =>
      @ul class: 'list-group', id: 'issue-list', outlet: 'list'

  getTitle: ->
    "Github: Issues"

  getURI: -> 'atom://github-plus:list-issues'

  addIssue: (issue) ->
    $(=>
      @list.append $$ ->
        @li class: 'list-item', id: 'issue-' + issue.id, =>
          @tag 'details', =>
            @tag 'summary', class: 'inline-block', =>
              @h2 class: 'inline-block', style: 'margin-top:0', issue.title
              @div class: 'inline-block text-subtle', "created_at " + new Date(issue.created_at).toLocaleString()
              @div class: 'inline-block badge badge-flexible icon icon-comment', issue.comments
            @div class: 'block', =>
              @div class: 'inline-block', =>
                @span class: 'inline-block badget badget-success icon icon-issue-opened', 'Opened'
                @span class: 'inline-block highlight', label.name for label in issue.labels
              @div class: 'block text-highlight', issue.body
      this.on 'click', '#issue-' + issue.id, =>
        if issue.lazy['comment'] && issue.comments isnt 0
          issue.loadComment().then =>
            @addComment(issue)
    )

  addComment: (issue) ->
    @find("#issue-#{issue.id} details").append $$ ->
      (@div class: 'block', =>
        @tag 'atom-panel', class: 'top', =>
          @div class: 'padded', =>
            @div class: 'inset-panel', =>
              @div class: 'panel-heading', "#{comment.user.login} comments on #{new Date(comment.updated_at).toLocaleString()}"
              @div class: 'panel-body padded', comment.body) for comment in issue.comments

  clear: ->
    @list.empty()
