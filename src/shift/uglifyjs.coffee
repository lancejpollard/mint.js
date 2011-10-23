class UglifyJS
  compressor: ->
    require("uglify-js").uglify
  
  parser: ->
    require("uglify-js").parser
  
  render: (string) ->
    ast = @parser().parse(string)
    ast = @compressor().ast_mangle(ast)
    ast = @compressor().ast_squeeze(ast)
    @compressor().gen_code(ast)
    
  compress: (string) ->
    @render(string)
    
module.exports = UglifyJS
