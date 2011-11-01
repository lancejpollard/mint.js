(function() {
  var YuiCompressor;
  YuiCompressor = (function() {
    function YuiCompressor() {}
    YuiCompressor.prototype.compressor = function() {
      return require("../../vendor/cssmin").cssmin;
    };
    YuiCompressor.prototype.render = function(content, options, callback) {
      var error, result;
      if (typeof options === "function") {
        callback = options;
        options = {};
      }
      options || (options = {});
      error = null;
      try {
        result = this.compressor()(content);
      } catch (e) {
        error = e;
      }
      if (callback) {
        callback.call(this, error, result);
      }
      return result;
    };
    YuiCompressor.prototype.compress = function(string) {
      return this.render(string);
    };
    return YuiCompressor;
  })();
  module.exports = YuiCompressor;
}).call(this);
