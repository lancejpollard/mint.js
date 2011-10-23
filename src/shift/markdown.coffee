class Markdown
  engine: -> require('markdown')
  
  render: (content, options) ->
    @engine().parse content
    
exports = module.exports = Markdown
