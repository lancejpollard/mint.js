(function() {
  var YuiCompressor;
  YuiCompressor = (function() {
    function YuiCompressor() {}
    YuiCompressor.prototype.compressor = function() {
      return require("../../vendor/cssmin").cssmin;
    };
    YuiCompressor.prototype.render = function(string) {
      return this.compressor()(string);
    };
    YuiCompressor.prototype.compress = function(string) {
      return this.render(string);
    };
    return YuiCompressor;
  })();
  module.exports = YuiCompressor;
}).call(this);
