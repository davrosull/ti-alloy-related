module.exports =
  config:
    useSplitPanes:
      type: 'boolean'
      default: true

  activate: ->
    atom.workspaceView.command "ti-alloy-related:openRelated", => @openRelated()

  openRelated: ->
    editor = atom.workspace.getActiveEditor()
    return unless editor?

    previousActivePane = atom.workspace.getActivePane()
    uri = "#{editor.getPath()}"

    if uri.indexOf('.js') > 0
      view = uri.replace('/controllers/', '/views/')
      view = view.replace('.js', '.xml')
      style = uri.replace('/controllers/', '/styles/')
      style = style.replace('.js', '.tss')
    else if uri.indexOf('.xml') > 0
      view = uri.replace('/views/', '/controllers/')
      view = view.replace('.xml', '.js')
      style = uri.replace('/views/', '/styles/')
      style = style.replace('.xml', '.tss')
    else if uri.indexOf('.tss') > 0
      view = uri.replace('/styles/', '/views/')
      view = view.replace('.tss', '.xml')
      style = uri.replace('/styles/', '/controllers/')
      style = style.replace('.tss', '.js')

    if atom.config.get "ti-alloy-related.useSplitPanes"
      atom.workspaceView.getActivePane().splitRight()
    atom.workspace.open(view)

    if atom.config.get "ti-alloy-related.useSplitPanes"
      atom.workspaceView.getActivePane().splitDown()
    atom.workspace.open(style)
