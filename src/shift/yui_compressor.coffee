class YuiCompressor
  compressor: ->
    require("../../vendor/cssmin").cssmin
    
  render: (content, options, callback) ->
    if typeof(options) == "function"
      callback    = options
      options     = {}
    options ||= {}
    error = null
    
    try
      result = @compressor()(content)
    catch e
      error = e
      
    callback.call(@, error, result) if callback
    
    result
    
  compress: (string) ->
    @render(string)
    
module.exports = YuiCompressor
