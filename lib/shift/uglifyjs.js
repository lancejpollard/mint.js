(function() {
  var UglifyJS;
  UglifyJS = (function() {
    function UglifyJS() {}
    UglifyJS.prototype.compressor = function() {
      return require("uglify-js").uglify;
    };
    UglifyJS.prototype.parser = function() {
      return require("uglify-js").parser;
    };
    UglifyJS.prototype.render = function(string) {
      var ast;
      ast = this.parser().parse(string);
      ast = this.compressor().ast_mangle(ast);
      ast = this.compressor().ast_squeeze(ast);
      return this.compressor().gen_code(ast);
    };
    UglifyJS.prototype.compress = function(string) {
      return this.render(string);
    };
    return UglifyJS;
  })();
  module.exports = UglifyJS;
}).call(this);
