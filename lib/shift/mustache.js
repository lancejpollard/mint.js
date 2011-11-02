(function() {
  var Mustache, exports;
  Mustache = (function() {
    function Mustache() {}
    Mustache.prototype.engine = function() {
      return require('mustache');
    };
    Mustache.prototype.render = function(content, options, callback) {
      var error, preprocessor, result;
      if (typeof options === "function") {
        callback = options;
        options = {};
      }
      options || (options = {});
      error = null;
      preprocessor = options.preprocessor || this.constructor.preprocessor;
      if (preprocessor) {
        content = preprocessor.call(this, content, options);
      }
      try {
        result = this.engine().to_html(content, options.locals);
      } catch (e) {
        error = e;
      }
      if (callback) {
        callback.call(this, error, result);
      }
      return result;
    };
    return Mustache;
  })();
  exports = module.exports = Mustache;
}).call(this);
