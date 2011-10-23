# Shift.js

> Standard Interface to the Node.js Template Engines.

## Install

``` bash
npm install shift
```

## Engines

``` coffeescript
new Shift.CoffeeScript
new Shift.Ejs
new Shift.Haml
new Shift.Jade
new Shift.Less
new Shift.Markdown
new Shift.Mustache
new Shift.Stylus
new Shift.UglifyJS
new Shift.YuiCompressor
```

## Example

``` coffeescript
Shift     = require('shift')
mustache  = new Shift.Mustache()
mustache.render "{title}!", locals: title: "Hello World", (string) -> console.log(string) #=> "Hello World!"
```

or more formally:

``` coffeescript
engine    = new Shift.Jade
input     = fs.readFileSync("./spec/fixtures/views/jade.jade", "utf-8")
output    = fs.readFileSync("./spec/fixtures/views/jade.html", "utf-8")
engine.render input, (error, result) ->
  expect(result).toEqual output
```

## API

``` coffeescript
engine = new Shift.CoffeeScript
engine.render(string, options, callback)
```

## Development

``` bash
./node_modules/coffee-script/bin/coffee -o lib -w src
./node_modules/jasmine-node/bin/jasmine-node --coffee ./spec
```

## License

(The MIT License)

Copyright &copy; 2011 [Lance Pollard](http://twitter.com/viatropos) &lt;lancejpollard@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
