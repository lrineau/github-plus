{CompositeDisposable} = require 'atom'
Issue = require './issue'
$ = require 'jquery'

module.exports = AtomGithubPlus =
  config:
    privateAccessToken:
      type: 'string'
      default: ''
      description: 'Your private access token'

  subscriptions: null

  activate: (state) ->
    $.ajaxSetup({cache:false})
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add('atom-workspace', 'github-plus:list-issues', ->Issue.commandList())

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
