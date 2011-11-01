Shift =
  Stylus:               require('./shift/stylus')
  Jade:                 require('./shift/jade')
  Haml:                 require('./shift/haml')
  Ejs:                  require('./shift/ejs')
  CoffeeScript:         require('./shift/coffee_script')
  Less:                 require('./shift/less')
  Mustache:             require('./shift/mustache')
  Markdown:             require('./shift/markdown')
  Sprite:               require('./shift/sprite')
  YuiCompressor:        require('./shift/yui_compressor')
  UglifyJS:             require('./shift/uglifyjs')
  
  engine: (extension) ->
    extension = extension.replace(/^\./, '')
    
    @engines[extension] ||= switch extension
      when "styl", "stylus"
        new Shift.Stylus
      when "jade"
        new Shift.Jade
      when "haml"
        new Shift.Haml
      when "ejs"
        new Shift.Ejs
      when "coffee", "coffeescript", "coffee-script"
        new Shift.CoffeeScript
      when "less"
        new Shift.Less
      when "mu", "mustache"
        new Shift.Mustache
      when "md", "mkd", "markdown", "mdown"
        new Shift.Markdown
    
  engines: {}
  
module.exports = Shift
