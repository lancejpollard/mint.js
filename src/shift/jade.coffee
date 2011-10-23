class Jade
  engine: -> require('jade')
  
  render: (content, options, callback) ->
    self          = @
    result        = ""
    if typeof(options) == "function"
      callback    = options
      options     = {}
    options ?= {}
    
    @engine().render content, options, (error, data) ->
      result = data
      callback.call(self, error, result) if callback
      
    result
    
exports = module.exports = Jade
