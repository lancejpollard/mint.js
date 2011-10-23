class Yui
  compressor: ->
    require("../../vendor/cssmin").cssmin
    
  render: (string) ->
    @compressor()(string)
    
  compress: (string) ->
    @render(string)
    
module.exports = Yui
