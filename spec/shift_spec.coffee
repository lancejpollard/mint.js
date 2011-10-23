Shift = require('../lib/shift')

fs = require('fs')

describe "shift", ->
  it "should render minified css with yui", ->
    engine    = new Shift.Yui
    input     = "body { background: red; }"
    output    = "body{background:red}"
    
    expect(engine.render(input)).toEqual output
  
  it "should use the UglifyJS compressor", ->
    engine    = new Shift.Uglifier
    input     = '''
    $(document).ready(function() {
      alert("ready!")
    });
    '''
    output    = '$(document).ready(function(){alert("ready!")})'
    
    expect(engine.render(input)).toEqual output
  
  it "should render stylus", ->
    engine    = new Shift.Stylus
    input     = fs.readFileSync("./spec/fixtures/stylesheets/stylus.styl", "utf-8")
    output    = fs.readFileSync("./spec/fixtures/stylesheets/stylus.css", "utf-8")
    expect(engine.render(input)).toEqual output
      
  it "should render jade", ->
    engine    = new Shift.Jade
    input     = fs.readFileSync("./spec/fixtures/views/jade.jade", "utf-8")
    output    = fs.readFileSync("./spec/fixtures/views/jade.html", "utf-8")
    engine.render input, (error, result) ->
      expect(result).toEqual output

  it "should render haml", ->
    engine    = new Shift.Haml
    input     = fs.readFileSync("./spec/fixtures/views/haml.haml", "utf-8")
    output    = fs.readFileSync("./spec/fixtures/views/haml.html", "utf-8")
    engine.render input, (error, result) ->
      expect(result).toEqual output

  it "should render ejs", ->
    engine    = new Shift.Ejs
    input     = fs.readFileSync("./spec/fixtures/views/ejs.ejs", "utf-8")
    output    = fs.readFileSync("./spec/fixtures/views/ejs.html", "utf-8")
    engine.render input, {locals: {name: "My Name"}}, (error, result) ->
      expect(result).toEqual output

  it "should render coffee script", ->
    engine    = new Shift.CoffeeScript
    input     = fs.readFileSync("./spec/fixtures/javascripts/coffee.coffee", "utf-8")
    output    = fs.readFileSync("./spec/fixtures/javascripts/coffee.js", "utf-8")
    result = engine.render input, {locals: {name: "My Name"}}
    expect(result).toEqual output

  it "should render less", ->
    engine    = new Shift.Less
    input     = fs.readFileSync("./spec/fixtures/stylesheets/less.less", "utf-8")
    output    = fs.readFileSync("./spec/fixtures/stylesheets/less.css", "utf-8")
    result    = engine.render input
    expect(result).toEqual output

  it "should render mustache", ->
    engine    = new Shift.Mustache
    input     = fs.readFileSync("./spec/fixtures/views/mustache.mustache", "utf-8")
    output    = fs.readFileSync("./spec/fixtures/views/mustache.html", "utf-8")
    locals = {name: "World", say_hello: -> "Hello" }
    result = engine.render input, locals: locals
    expect(result).toEqual output
    
  it "should render markdown", ->
    engine    = new Shift.Markdown
    input     = fs.readFileSync("./spec/fixtures/docs/markdown.markdown", "utf-8")
    output    = fs.readFileSync("./spec/fixtures/docs/markdown.html", "utf-8")
    result = engine.render input
    expect(result).toEqual output
###      
  describe "sprite", ->
    it "should create a sprite map", ->
      engine = new Shift.Sprite
      images = _.map ["facebook.png", "github.png", "linkedIn.png", "twitter.png"], (file) -> "./spec/fixtures/images/#{file}"
      
      data = {}
      
      runs ->
        engine.montage images: images, (result) ->
          data = result
      
      waits 500
      
      runs ->
        expect(data[0]).toEqual
          format: 'png', width: 64, height: 64, depth: 8, path: './spec/fixtures/images/facebook.png', slug: 'facebook', y: 5
        expect(data[1]).toEqual
          format: 'png', width: 64, height: 64, depth: 8, path: './spec/fixtures/images/github.png', slug: 'github', y: 69
        expect(data[2]).toEqual
          format: 'png', width: 64, height: 64, depth: 8, path: './spec/fixtures/images/linkedIn.png', slug: 'linkedIn', y: 133
        expect(data[3]).toEqual
          format: 'png', width: 64, height: 64, depth: 8, path: './spec/fixtures/images/twitter.png', slug: 'twitter', y: 197
    
    it "should render stylus", ->
      engine = new Shift.Sprite
      images = _.map ["facebook.png", "github.png", "linkedIn.png", "twitter.png"], (file) -> "./spec/fixtures/images/#{file}"
      
      stylus = ""
      
      runs ->
        engine.render images: images, format: "stylus", (result) ->
          stylus = result
          
      waits 1000
      
      runs ->
        expect(stylus).toEqual '''
sprite(slug, x, y)
  if slug == "facebook"
    background: url(./spec/fixtures/images/facebook.png) 0px 5px no-repeat;
  else if slug == "github"
    background: url(./spec/fixtures/images/github.png) 0px 69px no-repeat;
  else if slug == "linkedIn"
    background: url(./spec/fixtures/images/linkedIn.png) 0px 133px no-repeat;
  else slug == "twitter"
    background: url(./spec/fixtures/images/twitter.png) 0px 197px no-repeat;

        '''
        
    it "should render css", ->
      engine = new Shift.Sprite
      images = _.map ["facebook.png", "github.png", "linkedIn.png", "twitter.png"], (file) -> "./spec/fixtures/images/#{file}"
      
      stylus = ""
      
      runs ->
        engine.render images: images, format: "css", name: "sprite", (result) ->
          stylus = result
          
      waits 1000
      
      runs ->
        expect(stylus).toEqual '''
.facebook-sprite {
  background: url(./spec/fixtures/images/facebook.png) 0px 5px no-repeat;
}
.github-sprite {
  background: url(./spec/fixtures/images/github.png) 0px 69px no-repeat;
}
.linkedIn-sprite {
  background: url(./spec/fixtures/images/linkedIn.png) 0px 133px no-repeat;
}
.twitter-sprite {
  background: url(./spec/fixtures/images/twitter.png) 0px 197px no-repeat;
}

        '''
###        