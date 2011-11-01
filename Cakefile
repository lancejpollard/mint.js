{spawn, exec}  = require 'child_process'

task 'coffee', ->
  coffee = spawn './node_modules/coffee-script/bin/coffee', ['-o', 'lib', '-w', 'src']
  coffee.stdout.on 'data', (data) -> console.log data.toString().trim()
  
task 'spec', ->
  jasmine = spawn './node_modules/jasmine-node/bin/jasmine-node', ['--coffee', './spec']
  jasmine.stdout.on 'data', (data) -> console.log data.toString().trim()