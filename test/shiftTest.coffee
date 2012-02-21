shift = require('../lib/shift')
fs    = require('fs')
global.assert = require("chai").assert

describe "shift", ->
  it 'should render sequentially based on filename', (done) ->
    output = '''
$(document).ready(function() {
  return alert("Hello World");
});
'''
    shift.render path: "test/fixtures/javascripts/some.extensions.js.coffee.ejs", locals: {word: "Hello World"}, (error, result) ->
      assert.equal result, output
      done()
  
  it 'should find engine', ->
    assert.equal shift.engine(".styl"), "stylus"
    assert.equal shift.engine("styl"), "stylus"

  it "should render minified css with yui", (done) ->
    input     = "body { background: red; }"
    output    = "body{background:red}"
    
    shift.yui input, {}, (error, result) ->
      console.log error
      assert.equal result, output
      done()
  
  it "should use the UglifyJS compressor", (done) ->
    input     = '''
    $(document).ready(function() {
      alert("ready!")
    });
    '''
    output    = '$(document).ready(function(){alert("ready!")})'
    
    shift.uglifyjs input, {}, (error, result) ->
      assert.equal result, output
      done()
  
  it "should render stylus", (done) ->
    input     = fs.readFileSync("./test/fixtures/stylesheets/stylus.styl", "utf-8")
    output    = fs.readFileSync("./test/fixtures/stylesheets/stylus.css", "utf-8")
    shift.stylus input, {}, (error, result) ->
      assert.equal result, output
      done()
  
  it "should throw error in stylus", (done) ->
    path      = "test/fixtures/stylesheets/stylus-error.styl"
    input     = fs.readFileSync(path, "utf-8")
    shift.stylus input, path: path, (error, result) ->
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
    shift.jade input, {}, (error, result) ->
      assert.equal result, output
      done()
    
  it "should render haml", (done) ->
    input     = fs.readFileSync("./test/fixtures/views/haml.haml", "utf-8")
    output    = fs.readFileSync("./test/fixtures/views/haml.html", "utf-8")
    shift.haml input, {}, (error, result) ->
      assert.equal result, output
      done()
  
  # it "should render doT", ->
  #   engine    = new shift.DoT
  #   input     = fs.readFileSync("./test/fixtures/views/doT.js", "utf-8")
  #   output    = fs.readFileSync("./test/fixtures/views/doT.html", "utf-8")
  #   engine.render input, (error, result) ->
  #     assert.equal result, output

  it "should render ejs", ->
    input     = fs.readFileSync("./test/fixtures/views/ejs.ejs", "utf-8")
    output    = fs.readFileSync("./test/fixtures/views/ejs.html", "utf-8")
    shift.ejs input, {locals: {name: "My Name"}}, (error, result) ->
      assert.equal result, output

  it "should render coffee script", ->
    input     = fs.readFileSync("./test/fixtures/javascripts/coffee.coffee", "utf-8")
    output    = fs.readFileSync("./test/fixtures/javascripts/coffee.js", "utf-8")
    shift.coffee input, {locals: {name: "My Name"}}, (error, result) ->
      assert.equal result, output
      
  it "should throw error with coffee script", ->
    path      = "test/fixtures/javascripts/coffee-error.coffee"
    input     = fs.readFileSync(path, "utf-8")
    shift.coffee input, path: path, (error, result) ->
      assert.equal error.message, 'missing ", starting on line 2, test/fixtures/javascripts/coffee-error.coffee'
      
  it "should render eco", (done) ->
    input     = fs.readFileSync("test/fixtures/views/eco.coffee", "utf-8")
    output    = fs.readFileSync("test/fixtures/views/eco.html", "utf-8")
    shift.eco input, locals: projects: [{ name: "Mobile app", url: "/projects/1", description: "Iteration 1" }], (error, result) ->
      assert.equal result, output
      done()
      
  it "should render coffeekup", (done) ->
    input     = fs.readFileSync("test/fixtures/views/kup.coffee", "utf-8")
    output    = fs.readFileSync("test/fixtures/views/kup.html", "utf-8")
    shift.coffeekup input, {}, (error, result) ->
      assert.equal result, output
      done()

  it "should render less", ->
    input     = fs.readFileSync("./test/fixtures/stylesheets/less.less", "utf-8")
    output    = fs.readFileSync("./test/fixtures/stylesheets/less.css", "utf-8")
    shift.less input, (error, result) ->
      assert.equal result, output
    
  it "should render mustache", ->
    input     = fs.readFileSync("./test/fixtures/views/mustache.mustache", "utf-8")
    output    = fs.readFileSync("./test/fixtures/views/mustache.html", "utf-8")
    locals = {name: "World", say_hello: -> "Hello" }
    shift.mustache input, locals: locals, (error, result) ->
      assert.equal result, output
    
  it "should render markdown", ->
    input     = fs.readFileSync("./test/fixtures/docs/markdown.markdown", "utf-8")
    output    = fs.readFileSync("./test/fixtures/docs/markdown.html", "utf-8")
    shift.markdown input, (error, result) ->
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
        
    shift.stylus input, options, (error, result) ->
      assert.equal result, output
      
    shift.stylus.preprocessor = (content) ->
      content.replace /(\s+)(.*),\s+(?:\/\*.*\*\/)?\s*/mg, (_, indent, attribute) ->
        "#{indent}#{attribute.replace(/\s+/g, " ")}, "
    
    shift.stylus input, (error, result) ->
      assert.equal result, output
    
###      
  describe "sprite", ->
    it "should create a sprite map", ->
      engine = new shift.Sprite
      images = _.map ["facebook.png", "github.png", "linkedIn.png", "twitter.png"], (file) -> "./test/fixtures/images/#{file}"
      
      data = {}
      
      runs ->
        engine.montage images: images, (result) ->
          data = result
      
      waits 500
      
      runs ->
        assert.equal data[0],
          format: 'png', width: 64, height: 64, depth: 8, path: './test/fixtures/images/facebook.png', slug: 'facebook', y: 5
        assert.equal data[1],
          format: 'png', width: 64, height: 64, depth: 8, path: './test/fixtures/images/github.png', slug: 'github', y: 69
        assert.equal data[2],
          format: 'png', width: 64, height: 64, depth: 8, path: './test/fixtures/images/linkedIn.png', slug: 'linkedIn', y: 133
        assert.equal data[3],
          format: 'png', width: 64, height: 64, depth: 8, path: './test/fixtures/images/twitter.png', slug: 'twitter', y: 197
    
    it "should render stylus", ->
      engine = new shift.Sprite
      images = _.map ["facebook.png", "github.png", "linkedIn.png", "twitter.png"], (file) -> "./test/fixtures/images/#{file}"
      
      stylus = ""
      
      runs ->
        engine.render images: images, format: "stylus", (result) ->
          stylus = result
          
      waits 1000
      
      runs ->
        assert.equal stylus, '''
sprite(slug, x, y)
  if slug == "facebook"
    background: url(./test/fixtures/images/facebook.png) 0px 5px no-repeat;
  else if slug == "github"
    background: url(./test/fixtures/images/github.png) 0px 69px no-repeat;
  else if slug == "linkedIn"
    background: url(./test/fixtures/images/linkedIn.png) 0px 133px no-repeat;
  else slug == "twitter"
    background: url(./test/fixtures/images/twitter.png) 0px 197px no-repeat;

        '''
        
    it "should render css", ->
      engine = new shift.Sprite
      images = _.map ["facebook.png", "github.png", "linkedIn.png", "twitter.png"], (file) -> "./test/fixtures/images/#{file}"
      
      stylus = ""
      
      runs ->
        engine.render images: images, format: "css", name: "sprite", (result) ->
          stylus = result
          
      waits 1000
      
      runs ->
        assert.equal stylus, '''
.facebook-sprite {
  background: url(./test/fixtures/images/facebook.png) 0px 5px no-repeat;
}
.github-sprite {
  background: url(./test/fixtures/images/github.png) 0px 69px no-repeat;
}
.linkedIn-sprite {
  background: url(./test/fixtures/images/linkedIn.png) 0px 133px no-repeat;
}
.twitter-sprite {
  background: url(./test/fixtures/images/twitter.png) 0px 197px no-repeat;
}

        '''
###        