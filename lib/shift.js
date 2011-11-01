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
    UglifyJS: require('./shift/uglifyjs'),
    engine: function(extension) {
      var _base;
      extension = extension.replace(/^\./, '');
      return (_base = this.engines)[extension] || (_base[extension] = (function() {
        switch (extension) {
          case "styl":
          case "stylus":
            return new Shift.Stylus;
          case "jade":
            return new Shift.Jade;
          case "haml":
            return new Shift.Haml;
          case "ejs":
            return new Shift.Ejs;
          case "coffee":
          case "coffeescript":
          case "coffee-script":
            return new Shift.CoffeeScript;
          case "less":
            return new Shift.Less;
          case "mu":
          case "mustache":
            return new Shift.Mustache;
          case "md":
          case "mkd":
          case "markdown":
          case "mdown":
            return new Shift.Markdown;
        }
      })());
    },
    engines: {}
  };
  module.exports = Shift;
}).call(this);
