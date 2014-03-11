module.exports =
  activate: ->
    atom.workspaceView.command "ti-alloy-related:openRelated", => @openRelated()

  openRelated: ->
    editor = atom.workspace.getActiveEditor()
    return unless editor?

    previousActivePane = atom.workspace.getActivePane()
    uri = "#{editor.getPath()}"

    view = uri.replace('/controllers/', '/views/')
    view = view.replace('.js', '.xml')
    style = uri.replace('/controllers/', '/styles/')
    style = style.replace('.js', '.tss')

    atom.workspace.open(view, split: 'right', activatePane:false)
    atom.workspace.open(style, split: 'right', activatePane:false)
