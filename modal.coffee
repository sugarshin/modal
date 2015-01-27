$ = require 'jquery'
inherits = require 'inherits'
EventEmitter2 = require('eventemitter2').EventEmitter2

class Modal
  "use strict"

  inherits @, EventEmitter2

  _anyOpened = false
  @isAnyOpened: -> return _anyOpened

  _defaults:
    wrapper: '.js-modal-wrapper'
    open: '.js-modal-open'
    close: '.js-modal-close'
    toggle: '.js-modal-toggle'
    type: ''
    isOpen: false

  constructor: (opts) ->
    EventEmitter2.call @
    @opts = $.extend {}, @_defaults, opts
    @$wrapper = $(@opts.wrapper)
    @$open = $(@opts.open)
    @$toggle = $(@opts.toggle)
    @$close = $(@opts.close)

    # @compiledHtml = JST[@opts.type]()
    @addOpenEvent()
    @addToggleEvent()

    if @opts.isOpen then @open()

  isOpened: -> return @opts.isOpen

  render: ->
    @$wrapper.append @compiledHtml
    return this

  open: ->
    # if _anyOpened then return this
    if @isOpened() then return this
    @opts.isOpen = true
    _anyOpened = true

    @render()

    @$wrapper
      .stop true, true
      .fadeIn => @emit 'afterfadein'

    @emit 'open'
    return this

  empty: ->
    @$wrapper.empty()
    return this

  close: ->
    @opts.isOpen = false
    _anyOpened = false

    @$wrapper
      .stop true, true
      .fadeOut => @emit 'afterfadeout'

    @emit 'close'
    return this

  toggle: ->
    if @isOpened()
      @close()
    else
      @open()
    return this

  addOpenEvent: ->
    @$open.on 'click.openmodal', (ev) =>
      ev.preventDefault()
      @open().addCloseEvent()
    return this

  addToggleEvent: ->
    @$toggle.on 'click.togglemodal', (ev) =>
      ev.preventDefault()
      @toggle()
    return this

  addCloseEvent: ->
    @$wrapper
      .find(@opts.close)
      .on 'click.closemodal', (ev) =>
        ev.preventDefault()
        @close().empty()
    return this

if typeof define is 'function' and define.amd
  define -> Modal
else if typeof module isnt 'undefined' and module.exports
  module.exports = Modal
else
  window.Modal or= Modal
