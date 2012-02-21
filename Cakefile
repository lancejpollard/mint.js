{exec, spawn} = require 'child_process'
sys           = require('util')

task 'coffee', 'Auto compile src/**/*.coffee files into lib/**/*.js', ->
  coffee = spawn './node_modules/coffee-script/bin/coffee', ['-o', '.', '-w', 'src']
  coffee.stdout.on 'data', (data) -> console.log data.toString().trim()
  coffee.stderr.on 'data', (data) -> console.log data.toString().trim()
