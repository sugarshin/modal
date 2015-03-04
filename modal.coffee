###!
 * @license modal
 * (c) sugarshin
 * License: MIT
###

"use strict"

do (root = this, factory = ($, EventEmitter) ->

  class Modal extends EventEmitter

    _$body = $(document.body)

    _modalElement = '<div class="modal-wrapper js-modal-wrapper">
                      <div class="modal-bg js-modal-bg"></div>
                      <div class="modal js-modal">
                        <div class="modal-inner js-modal-inner">
                          <div class="modal-body js-modal-body">
                          </div>
                        </div>
                      </div>
                    </div>'

    _anyOpend = false

    @setBaseElement: (el) -> _modalElement = el
    @isAnyOpened: -> _anyOpend

    _defaults:
      width: 640
      height: 360
      # fade: false
      wrapperSelector: '.js-modal-wrapper'
      bgSelector: '.js-modal-bg'
      coreSelector: '.js-modal'
      bodySelector: '.js-modal-body'
      closeSelector: '.js-close-modal'

    _configure: (el, opts) ->
      @$el = $(el)
      @opts = $.extend {}, @_defaults, opts

    _getScrollbarWidth: ->
      div = document.createElement 'div'
      div.style.width = '100px'
      div.style.height = '100px'
      div.style.overflow = 'scroll'
      div.style.position = 'absolute'
      div.style.top = '-9999px'
      document.body.appendChild div
      scrollbarWidth = div.offsetWidth - div.clientWidth
      document.body.removeChild div
      return scrollbarWidth

    constructor: (@el, opts) ->
      @_configure @el, opts
      EventEmitter.call @
      @evnets()

    render: (el) ->
      $(@opts.bodySelector).append el
      return this

    set: (name, val) ->
      @opts[name] = val

    open: ->
      if _anyOpend then return
      @_opened = _anyOpend = true
      scrollBarWidth = @_getScrollbarWidth()
      @_normalBodyMarginRight = _$body.css 'margin-right'
      _$body
        .css 'margin-right', scrollBarWidth
        .append _modalElement
        .css 'overflow', 'hidden'

      $(@opts.coreSelector).css
        width: @opts.width
        height: @opts.height
        marginTop: -@opts.height / 2
        marginLeft: -@opts.width / 2

      @closeEvent()
      @emit 'open', @el, this
      return this

    close: ->
      @_opened = _anyOpend = false
      _$body.css
        marginRight: @_normalBodyMarginRight
        overflow: 'visible'
      $(@opts.wrapperSelector).remove()
      @emit 'close', @el, this
      return this

    evnets: ->
      @$el.on 'click.openmodal', (ev) =>
        ev?.preventDefault?()
        @open()
      return this

    unbind: ->
      @$el.off 'click.openmodal'
      return this

    closeEvent: ->
      $("#{@opts.closeSelector}, #{@opts.bgSelector}").on 'click.closemodal', (ev) =>
        ev?.preventDefault?()
        @close()
      return this

) ->
  if typeof module is 'object' and typeof module.exports is 'object'
    module.exports = factory require('jquery'), require('events').EventEmitter
  else
    root.Modal or= factory root.jQuery, root.EventEmitter
  return
