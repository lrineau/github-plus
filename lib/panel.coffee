module.exports =
  splitRight: (old)->
    pane = atom.workspace.paneForItem(old)
    pane = pane.splitRight(copyActiveItem: true).getActiveEditor()
    old.destroy()
    pane
  splitUp: (old)->
    pane = atom.workspace.paneForItem(old)
    pane = pane.splitUp(copyActiveItem: true).getActiveEditor()
    old.destroy()
    pane
  splitDown: (old)->
    pane = atom.workspace.paneForItem(old)
    pane = pane.splitDown(copyActiveItem: true).getActiveEditor()
    old.destroy()
    pane
  splitLeft: (old)->
    pane = atom.workspace.paneForItem(old)
    pane = pane.splitLeft(copyActiveItem: true).getActiveEditor()
    old.destroy()
    pane
