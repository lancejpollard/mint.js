module.exports =
  engines: {}

  engine: (extension) ->
    extension = extension.replace(/^\./, '')

    @engines[extension] ||= switch extension
      when "styl", "stylus"
        "stylus"
      when "jade"
        "jade"
      when "eco"
        "eco"
      when "haml"
        "haml"
      when "ejs"
        "ejs"
      when "coffee", "coffeescript", "coffee-script"
        "coffee"
      when "less"
        "less"
      when "mu", "mustache"
        "mustache"
      when "md", "mkd", "markdown", "mdown"
        "markdown"

  # Pass in path, it computes the extensions and what engine you'll want
  enginesFor: (path) ->
    engines     = []
    extensions  = path.split("/")
    extensions  = extensions[extensions.length - 1]
    extensions  = extensions.split(".")[1..-1]

    for extension in extensions
      engine    = @engine(extension)
      engines.push engine if engine

    engines

  render: (options, callback) ->
    path        = options.path
    string      = options.string  || require('fs').readFileSync(path, 'utf-8')
    engines     = options.engines || @enginesFor(path)

    iterate = (engine, next) =>
      @[engine] string, options, (error, output) =>
        if error
          next(error)
        else
          string = output
          next()

    @_async engines, iterate, (error) =>
      callback.call(@, error, string)

  stylus: (content, options, callback) ->
    result        = ""
    path          = options.path

    preprocessor  = options.preprocessor || @stylus.preprocessor
    content       = preprocessor.call(@, content, options) if preprocessor

    engine        = require('stylus')

    engine.render content, options, (error, data) =>
      result      = data
      error.message = error.message.replace(/\n$/, ", #{path}\n") if error && path
      callback.call(@, error, result) if callback

    result

  jade: (content, options, callback) ->
    result        = ""
    path          = options.path
    preprocessor  = options.preprocessor || @jade.preprocessor
    content       = preprocessor.call(@, content, options) if preprocessor

    require("jade").render content, options, (error, data) =>
      result = data
      error.message += ", #{path}" if error && path
      callback.call(@, error, result) if callback

    result

  haml: (content, options, callback) ->
    result = require('hamljs').render(content, options || {})
    callback.call(@, null, result) if callback
    result

  ejs: (content, options, callback) ->
    result        = ""
    error         = null

    try
      result      = require("ejs").render(content, options)
    catch e
      error       = e
      result      = null

    callback.call(@, error, result) if callback

    result

  eco: (content, options, callback) ->
    result = require("eco").render content, options.locals
    callback.call @, null, result if callback
    result

  coffee: (content, options, callback) ->
    result        = ""
    path          = options.path

    options.bare  = true unless options.hasOwnProperty("bare")

    preprocessor  = options.preprocessor || @coffee.preprocessor
    content       = preprocessor.call(@, content, options) if preprocessor

    try
      result      = require("coffee-script").compile(content, options)
    catch e
      result      = null
      error       = e
      error.message += ", #{path}" if path

    callback.call(@, error, result) if callback

    result

  coffeekup: (content, options, callback) ->
    result = require("coffeekup").render content, options
    callback.call @, null, result if callback
    result

  less: (content, options, callback) ->
    result        = ""
    path          = options.path
    options.filename  = path
    options.paths   ||= []
    options.paths = ["."].concat options.paths
    engine = require("less")
    parser = new engine.Parser(options)

    try
      parser.parse content, (error, tree) =>
        if error
          error.message += ", #{path}" if path
        else
          try
            result = tree.toCSS()
          catch e
            error = e

        message = (error.message + ", " + path) if error
        callback.call(@, message, result) if callback

    catch error
      callback.call(@, error.message += ", " + path, "")
    result

  mustache: (content, options, callback) ->
    path          = options.path
    error         = null

    preprocessor  = options.preprocessor || @constructor.preprocessor
    content       = preprocessor.call(@, content, options) if preprocessor

    try
      result      = require("mustache").to_html content, options.locals
    catch e
      error       = e
      result      = null
      error.message += ", #{path}" if path

    callback.call(@, error, result) if callback

    result

  handlebars: (content, options, callback) ->


  markdown: (content, options, callback) ->
    error = null

    preprocessor = options.preprocessor || @constructor.preprocessor
    content = preprocessor.call(@, content, options) if preprocessor

    try
      result = require("markdown").parse content
    catch e
      error = e

    callback.call(@, error, result) if callback

    result

  yui: (content, options, callback) ->
    path          = options.path
    error         = null

    try
      result = require("./vendor/cssmin").cssmin(content)
    catch e
      error = e
      error.message += ", #{path}" if path

    callback.call(@, error, result) if callback

    result

  uglifyjs: (content, options, callback) ->
    path          = options.path
    error         = null
    parser        = require("uglify-js").parser
    compressor    = require("uglify-js").uglify

    try
      ast         = parser.parse(content)
      ast         = compressor.ast_mangle(ast)
      ast         = compressor.ast_squeeze(ast)
      result      = compressor.gen_code(ast)
    catch e
      error       = e
      error.message += ", #{path}" if path

    callback.call(@, error, result) if callback

    result

  _async: (array, iterator, callback) ->
    return callback() unless array.length
    completed = 0
    iterate = ->
      iterator array[completed], (error) ->
        if error
          callback error
          callback = ->
        else
          completed += 1
          if completed == array.length
            callback()
          else
            iterate()

    iterate()