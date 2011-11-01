(function() {
  var Markdown, exports;
  Markdown = (function() {
    function Markdown() {}
    Markdown.prototype.engine = function() {
      return require('markdown');
    };
    Markdown.prototype.render = function(content, options, callback) {
      var error, result;
      if (typeof options === "function") {
        callback = options;
        options = {};
      }
      options || (options = {});
      error = null;
      try {
        result = this.engine().parse(content);
      } catch (e) {
        error = e;
      }
      if (callback) {
        callback.call(this, error, result);
      }
      return result;
    };
    return Markdown;
  })();
  exports = module.exports = Markdown;
}).call(this);
