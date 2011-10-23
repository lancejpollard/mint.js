class Haml
  engine: -> require('hamljs')
  
  render: (content, options, callback) ->
    callback = options if typeof(options) == "function"
    data = @engine().render(content, options || {})
    callback.call(@, null, data)
    data
    
exports = module.exports = Haml
