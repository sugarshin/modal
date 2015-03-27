###!
 * @license modal
 * (c) sugarshin
 * License: MIT
###

"use strict"

EventEmitter = require('events').EventEmitter
crel = require 'crel'
event = require 'component-event'
style = require 'dom-style'
objectAssign = require 'object-assign'

module.exports =
class Modal extends EventEmitter

  querySelector = document.querySelector

  _body = document.body

  _baseElement = crel 'div', 'class': 'modal-wrapper js-modal-wrapper',
                  crel('div', 'class': 'modal-bg js-modal-bg'),
                  crel 'div', 'class': 'modal js-modal',
                    crel 'div', 'class': 'modal-inner js-modal-inner',
                      crel 'div', 'class': 'modal-body js-modal-body'

  _anyOpend = false

  @setBaseElement: (el) -> _baseElement = el
  @isAnyOpened: -> _anyOpend

  _defaults:
    width: 640
    height: 360
    wrapperSelector: '.js-modal-wrapper'
    bgSelector: '.js-modal-bg'
    coreSelector: '.js-modal'
    bodySelector: '.js-modal-body'
    closeSelector: '.js-close-modal'

  _configure: (opts) -> @opts = objectAssign {}, @_defaults, opts

  _getScrollbarWidth: ->
    div = crel 'div'
    style div,
      'width': '100px'
      'height': '100px'
      'overflow': 'scroll'
      'position': 'absolute'
      'top': '-9999px'
    document.body.appendChild div
    scrollbarWidth = div.offsetWidth - div.clientWidth
    document.body.removeChild div
    return scrollbarWidth

  _remove: (el) -> el.parentNode.removeChild el

  constructor: (@el, opts) ->
    EventEmitter.call @
    @_configure opts
    @evnets()

  render: (el) ->
    querySelector(@opts.bodySelector).append el
    return this

  set: (name, val) -> @opts[name] = val

  open: ->
    if _anyOpend then return
    @_opened = _anyOpend = true
    scrollBarWidth = @_getScrollbarWidth()
    @_normalBodyMarginRight = _body.style.marginRight
    style _body, 'margin-right', scrollBarWidth
    _body.append _baseElement
    style _body, 'overflow', 'hidden'

    style querySelector(@opts.coreSelector),
      'width': @opts.width
      'height': @opts.height
      'margin-top': -@opts.height / 2
      'margin-left': -@opts.width / 2

    @closeEvent()
    @emit 'open', @el, this
    return this

  close: ->
    @_opened = _anyOpend = false
    style _body,
      'margin-right': @_normalBodyMarginRight
      'overflow': 'visible'
    @_remove querySelector(@opts.wrapperSelector)
    @emit 'close', @el, this
    return this

  evnets: ->
    event.bind @el, 'click', (ev) =>
      ev?.preventDefault()
      @open()
    return this

  unbind: ->
    event.unbind @el, 'click'
    return this

  closeEvent: ->
    els = [
      querySelector @opts.closeSelector
      querySelector @opts.bgSelector
    ]
    for el, i in els
      event.bind el, 'click', (ev) =>
        ev?.preventDefault()
        @open()
    return this
