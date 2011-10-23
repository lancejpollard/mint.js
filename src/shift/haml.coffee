class Haml
  engine: -> require('hamljs')
  
  compile: (content, options, callback) ->
    callback = options if typeof(options) == "function"
    data = @engine().render(content, options || {})
    callback.call(@, null, data)
    data
    
exports = module.exports = Haml
