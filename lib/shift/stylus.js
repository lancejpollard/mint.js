(function() {
  var Stylus;
  Stylus = (function() {
    function Stylus() {}
    Stylus.prototype.engine = function() {
      return require('stylus');
    };
    Stylus.prototype.render = function(content, options, callback) {
      var engine, preprocessor, result, self;
      result = "";
      self = this;
      if (typeof options === "function") {
        callback = options;
        options = {};
      }
      options || (options = {});
      preprocessor = options.preprocessor || this.constructor.preprocessor;
      if (preprocessor) {
        content = preprocessor.call(this, content, options);
      }
      engine = this.engine();
      engine.render(content, options, function(error, data) {
        result = data;
        if (callback) {
          return callback.call(self, error, result);
        }
      });
      return result;
    };
    return Stylus;
  })();
  module.exports = Stylus;
}).call(this);
