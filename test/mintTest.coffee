mint = require('../mint')
fs    = require('fs')
global.assert = require("chai").assert

describe "mint", ->
  it 'should render sequentially based on filename', (done) ->
    output = '''

$(document).ready(function() {
  return alert("Hello World");
});

'''
    mint.render path: "test/fixtures/javascripts/some.extensions.js.coffee.ejs", locals: {word: "Hello World"}, (error, result) ->
      assert.equal result, output
      done()

  it 'should find engine', ->
    assert.equal mint.engine(".styl"), "stylus"
    assert.equal mint.engine("styl"), "stylus"
    assert.equal mint.engine("eco"), "eco"

  it "should render minified css with yui", (done) ->
    input     = "body { background: red; }"
    output    = "body{background:red}"

    mint.yui input, {}, (error, result) ->
      assert.equal result, output
      done()

  it "should use the UglifyJS compressor", (done) ->
    input     = '''
    $(document).ready(function() {
      alert("ready!")
    });
    '''
    output    = '$(document).ready(function(){alert("ready!")})'

    mint.uglifyjs input, {}, (error, result) ->
      assert.equal result, output
      done()

  it "should render stylus", (done) ->
    input     = fs.readFileSync("./test/fixtures/stylesheets/stylus.styl", "utf-8")
    output    = fs.readFileSync("./test/fixtures/stylesheets/stylus.css", "utf-8")
    mint.stylus input, {}, (error, result) ->
      assert.equal result, output
      done()

  it "should throw error in stylus", (done) ->
    path      = "test/fixtures/stylesheets/stylus-error.styl"
    input     = fs.readFileSync(path, "utf-8")
    mint.stylus input, path: path, (error, result) ->
      assert.equal error.message, '''
stylus:2
   1| body
 > 2|   background: red@

expected "indent", got "outdent", test/fixtures/stylesheets/stylus-error.styl

'''
      done()

  it "should render jade", (done) ->
    input     = fs.readFileSync("./test/fixtures/views/jade.jade", "utf-8")
    output    = fs.readFileSync("./test/fixtures/views/jade.html", "utf-8")
    mint.jade input, {}, (error, result) ->
      assert.equal result, output
      done()

  it "should render haml", (done) ->
    input     = fs.readFileSync("./test/fixtures/views/haml.haml", "utf-8")
    output    = fs.readFileSync("./test/fixtures/views/haml.html", "utf-8")
    mint.haml input, {}, (error, result) ->
      assert.equal result, output
      done()

  it "should render haml-coffee", (done) ->
    input     = fs.readFileSync("./test/fixtures/views/haml-coffee.hamlc", "utf-8")
    output    = fs.readFileSync("./test/fixtures/views/haml-coffee.html", "utf-8")
    mint.hamlcoffee input, locals: projects: [{ name: "Mobile app", url: "/projects/1", description: "Iteration 1" }], (error, result) ->
      assert.equal result, output
      done()

  # it "should render doT", ->
  #   engine    = new mint.DoT
  #   input     = fs.readFileSync("./test/fixtures/views/doT.js", "utf-8")
  #   output    = fs.readFileSync("./test/fixtures/views/doT.html", "utf-8")
  #   engine.render input, (error, result) ->
  #     assert.equal result, output

  it "should render ejs", ->
    input     = fs.readFileSync("./test/fixtures/views/ejs.ejs", "utf-8")
    output    = fs.readFileSync("./test/fixtures/views/ejs.html", "utf-8")
    mint.ejs input, {locals: {name: "My Name"}}, (error, result) ->
      assert.equal result, output

  it "should render coffee script", ->
    input     = fs.readFileSync("./test/fixtures/javascripts/coffee.coffee", "utf-8")
    output    = fs.readFileSync("./test/fixtures/javascripts/coffee.js", "utf-8")
    mint.coffee input, {locals: {name: "My Name"}}, (error, result) ->
      assert.equal result, output

  it "should throw error with coffee script", ->
    path      = "test/fixtures/javascripts/coffee-error.coffee"
    input     = fs.readFileSync(path, "utf-8")
    mint.coffee input, path: path, (error, result) ->
      assert.equal error.message, 'missing ", starting on line 2, test/fixtures/javascripts/coffee-error.coffee'

  it "should render eco", (done) ->
    input     = fs.readFileSync("test/fixtures/views/eco.coffee", "utf-8")
    output    = fs.readFileSync("test/fixtures/views/eco.html", "utf-8")
    mint.eco input, locals: projects: [{ name: "Mobile app", url: "/projects/1", description: "Iteration 1" }], (error, result) ->
      assert.equal result, output
      done()

  it "should render coffeekup", (done) ->
    input     = fs.readFileSync("test/fixtures/views/kup.coffee", "utf-8")
    output    = fs.readFileSync("test/fixtures/views/kup.html", "utf-8")
    mint.coffeekup input, {}, (error, result) ->
      assert.equal result, output
      done()

  it "should render less", ->
    input     = fs.readFileSync("./test/fixtures/stylesheets/less.less", "utf-8")
    output    = fs.readFileSync("./test/fixtures/stylesheets/less.css", "utf-8")
    mint.less input, (error, result) ->
      assert.equal result, output

  it "should render mustache", ->
    input     = fs.readFileSync("./test/fixtures/views/mustache.mustache", "utf-8")
    output    = fs.readFileSync("./test/fixtures/views/mustache.html", "utf-8")
    locals = {name: "World", say_hello: -> "Hello" }
    mint.mustache input, locals: locals, (error, result) ->
      assert.equal result, output

  it "should render handlebars", ->
	input = fs.readFileSync("./test/fixtures/views/handlebars.hbs", "utf-8")
	output = fs.readFileSync("./test/fixtures/views/handlebars.html", "utf-8")
	locals=
		name: 'Vadim'

	mint.handlebars input, locals: locals, (error, result) ->
		assert.equal result, output

  it "should render markdown", ->
    input     = fs.readFileSync("./test/fixtures/docs/markdown.markdown", "utf-8")
    output    = fs.readFileSync("./test/fixtures/docs/markdown.html", "utf-8")
    mint.markdown input, (error, result) ->
      assert.equal result, output

  it 'should allow preprocessing stylus', ->
    input = '''
div
  box-shadow: 0 -2px 2px            hsl(220, 20%, 40%),
    0 -10px 10px          hsl(220, 20%, 20%),
    0 0 15px              black,

    inset 0 5px 1px       hsla(220, 80%, 10%, 0.4),
    inset 0 0 5px         hsla(220, 80%, 10%, 0.1),
    inset 0 20px 15px     hsla(220, 80%, 100%, 1),

    inset 0 1px 0         hsl(219, 20%, 0%),

    inset 0 -50px 50px -40px hsla(220, 80%, 10%, .3),  /* gradient to inset */

    inset 0 -1px 0px      hsl(220, 20%, 20%),
    inset 0 -2px 0px      hsl(220, 20%, 40%),
    inset 0 -2px 1px      hsl(220, 20%, 65%)
'''
    output    = '''
div {
  box-shadow: 0 -2px 2px #525f7a, 0 -10px 10px #29303d, 0 0 15px #000, inset 0 5px 1px rgba(5,19,46,0.40), inset 0 0 5px rgba(5,19,46,0.10), inset 0 20px 15px #fff, inset 0 1px 0 #000, inset 0 -50px 50px -40px rgba(5,19,46,0.30), inset 0 -1px 0px #29303d, inset 0 -2px 0px #525f7a, inset 0 -2px 1px #94a0b8;
}

'''
    options   =
      preprocessor: (content) ->
        content.replace /(\s+)(.*),\s+(?:\/\*.*\*\/)?\s*/mg, (_, indent, attribute) ->
          "#{indent}#{attribute.replace(/\s+/g, " ")}, "

    mint.stylus input, options, (error, result) ->
      assert.equal result, output

    mint.stylus.preprocessor = (content) ->
      content.replace /(\s+)(.*),\s+(?:\/\*.*\*\/)?\s*/mg, (_, indent, attribute) ->
        "#{indent}#{attribute.replace(/\s+/g, " ")}, "

    mint.stylus input, (error, result) ->
      assert.equal result, output
