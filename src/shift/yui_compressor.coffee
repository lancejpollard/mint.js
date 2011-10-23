class YuiCompressor
  compressor: ->
    require("../../vendor/cssmin").cssmin
    
  render: (string) ->
    @compressor()(string)
    
  compress: (string) ->
    @render(string)
    
module.exports = YuiCompressor
