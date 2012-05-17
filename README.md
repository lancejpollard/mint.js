# Mint.js

> Standard Interface to the Node.js Template Engines (JavaScript, CSS, text, etc.).

[![Build Status](https://secure.travis-ci.org/viatropos/mint.png)](http://travis-ci.org/viatropos/mint)

## Install

``` bash
npm install mint
```

## Engines

``` coffeescript
mint = require("mint")
mint.coffee
mint.coffeekup
mint.eco
mint.ejs
mint.haml
mint.hamlcoffee
mint.handlebars
mint.jade
mint.less
mint.stylus
mint.markdown
mint.mustache
mint.uglifyjs
mint.yui
```

## Example

``` coffeescript
mint     = require('mint')
mint.mustache "{title}!", locals: title: "Hello World", (string) -> console.log(string) #=> "Hello World!"
```

or more formally:

``` coffeescript
input     = fs.readFileSync("./test/fixtures/views/jade.jade", "utf-8")
output    = fs.readFileSync("./test/fixtures/views/jade.html", "utf-8")
mint.jade input, {}, (error, result) ->
  assert.equal result, output
```

or if you want just to compile a template(**Note**: supports only jade, haml, handlebars, eco, ejs):

``` coffeescript
fn = mint.compile template: input, engine: 'jade' # Function
fn title: 'Title', author: 'Some author' # String, rendered template
```

## API

``` coffeescript
mint[engine](string, options, callback)
```

## Preprocessing

Sometimes you might need to hack in a feature to the language.  Like right now, stylus doesn't support multiline values for css attributes, so you might add it like this:

``` coffeescript
input   = '''
div
  box-shadow: 0 -2px 2px  hsl(220, 20%, 40%),
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

output  = '''
div {
  box-shadow: 0 -2px 2px #525f7a, 0 -10px 10px #29303d, 0 0 15px #000, inset 0 5px 1px rgba(5,19,46,0.40), inset 0 0 5px rgba(5,19,46,0.10), inset 0 20px 15px #fff, inset 0 1px 0 #000, inset 0 -50px 50px -40px rgba(5,19,46,0.30), inset 0 -1px 0px #29303d, inset 0 -2px 0px #525f7a, inset 0 -2px 1px #94a0b8;
}

'''
# locally
options   =
  preprocessor: (content) ->
    content.replace /(\s+)(.*),\s+(?:\/\*.*\*\/)?\s*/mg, (_, indent, attribute) ->
      "#{indent}#{attribute.replace(/\s+/g, " ")}, "

mint.stylus input, options, (error, result) ->
  expect(result).toEqual output

# globally
mint.stylus.preprocessor = (content) ->
  content.replace /(\s+)(.*),\s+(?:\/\*.*\*\/)?\s*/mg, (_, indent, attribute) ->
    "#{indent}#{attribute.replace(/\s+/g, " ")}, "

mint.stylus input, {}, (error, result) ->
  expect(result).toEqual output
```

## Test

``` bash
mocha
```

## License

(The MIT License)

Copyright &copy; 2011 [Lance Pollard](http://twitter.com/viatropos) &lt;lancejpollard@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
