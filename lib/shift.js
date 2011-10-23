(function() {
  var Shift;
  Shift = {
    Stylus: require('./shift/stylus'),
    Jade: require('./shift/jade'),
    Haml: require('./shift/haml'),
    Ejs: require('./shift/ejs'),
    CoffeeScript: require('./shift/coffee_script'),
    Less: require('./shift/less'),
    Mustache: require('./shift/mustache'),
    Markdown: require('./shift/markdown'),
    Sprite: require('./shift/sprite'),
    YuiCompressor: require('./shift/yui_compressor'),
    UglifyJS: require('./shift/uglifyjs')
  };
  module.exports = Shift;
}).call(this);
