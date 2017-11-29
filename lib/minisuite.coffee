MinisuiteView = require './minisuite-view'
{CompositeDisposable} = require 'atom'

module.exports = Minisuite =
  minisuiteView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @minisuiteView = new MinisuiteView(state.minisuiteViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @minisuiteView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'minisuite:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @minisuiteView.destroy()

  serialize: ->
    minisuiteViewState: @minisuiteView.serialize()

  toggle: ->
    console.log 'Minisuite was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
