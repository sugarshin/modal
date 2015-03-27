jsdom = require('jsdom').jsdom
global.document = jsdom '<html><body></body></html>'
global.window = document.defaultView
global.navigator = window.navigator

assert = require 'power-assert'

Modal = require '../src/modal.coffee'

# .test()
describe '.test()', ->
  it 'test', ->
    assert true
