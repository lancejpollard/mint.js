class Stylus
  engine: -> require('stylus')
  
  render: (content, options, callback) ->
    result        = ""
    self = @
    if typeof(options) == "function"
      callback    = options
      options     = {}
    options ||= {}
    
    preprocessor = options.preprocessor || @constructor.preprocessor
    content = preprocessor.call(@, content, options) if preprocessor
    
    engine = @engine()
    
    engine.render content, options, (error, data) -> 
      result = data
      callback.call(self, error, result) if callback
      
    result
    
module.exports = Stylus
