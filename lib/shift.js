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
    Yui: require('./shift/yui'),
    Uglifier: require('./shift/uglifier')
  };
  module.exports = Shift;
}).call(this);
