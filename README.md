# modal

[![Build Status](https://travis-ci.org/sugarshin/modal.svg?branch=master)](https://travis-ci.org/sugarshin/modal) [![Coverage Status](https://coveralls.io/repos/sugarshin/modal/badge.svg)](https://coveralls.io/r/sugarshin/modal) [![GitHub version](https://badge.fury.io/gh/sugarshin%2Fmodal.svg)](http://badge.fury.io/gh/sugarshin%2Fmodal) [![License](http://img.shields.io/:license-mit-blue.svg)](http://sugarshin.mit-license.org/)

Modal

Semantic modal base

```shell
npm i sugarshin/modal
```

## Usage

```coffeescript
Modal = require 'modal'

m = new Modal element, opts
m.on 'open', (el, modal) ->
  # create modal content...
  modal.render content
```

or

```html
<script src="build/modal.js"></script>
<script>
  var m = new Modal(element, opts);
  m.on('open', function(el, modal) {
    // create modal content...
    modal.render(content);
  });
</script>
```

### Config

default options

```coffeescript
_defaults:
  width: 640
  height: 360
  wrapperSelector: '.js-modal-wrapper'
  bgSelector: '.js-modal-bg'
  coreSelector: '.js-modal'
  bodySelector: '.js-modal-body'
  closeSelector: '.js-close-modal'
```

## Contributing

deps

* component-event
* crel
* dom-style
* object-assign

```shell
npm test
```

**inpmplete test**

## License

[MIT](http://sugarshin.mit-license.org/)

© sugarshin
