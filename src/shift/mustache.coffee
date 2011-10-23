class Mustache
  engine: -> require('mustache')
  
  render: (content, options) ->
    @engine().to_html content, options.locals
    
exports = module.exports = Mustache
