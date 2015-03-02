# modal

[![Build Status](https://travis-ci.org/sugarshin/modal.svg?branch=master)](https://travis-ci.org/sugarshin/modal) [![Coverage Status](https://coveralls.io/repos/sugarshin/modal/badge.svg)](https://coveralls.io/r/sugarshin/modal) [![GitHub version](https://badge.fury.io/gh/sugarshin%2Fmodal.svg)](http://badge.fury.io/gh/sugarshin%2Fmodal) [![License](http://img.shields.io/:license-mit-blue.svg)](http://sugarshin.mit-license.org/)

Modal

Semantic modal base class

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
<script src="jquery.js"></script>
<script src="eventemitter.js"></script>
<script src="modal.js"></script>
<script>
  var m = new Modal(element, opts);
  m.on('open', function(el, modal) {
    // create modal content...
    modal.render(content);
  });
</script>
```

### Config

```coffeescript
_defaults:
  width: 640
  height: 360
  bodySelector: '.js-modal-body'
```

## Contributing

[CoffeeScript](//coffeescript.org/)

[mocha-phantomjs](//github.com/metaskills/mocha-phantomjs)

[power-assert](//github.com/twada/power-assert)

```shell
npm test
```

## License

[MIT](http://sugarshin.mit-license.org/)

© sugarshin
