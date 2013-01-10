# This is a work in progress - isn't used yet.

{spawn, exec} = require 'child_process'

task 'compile', 'Convert to JavaScript in preparation for publishing to npm', (options) ->
  runCommand = (name, args...) ->
    proc =          spawn name, args
    proc.stderr.on  'data', (buffer) -> console.log buffer.toString()
    proc.stdout.on  'data', (buffer) -> console.log buffer.toString()
    proc.on         'exit', (status) -> process.exit(1) if status isnt 0
  runCommand 'coffee', '-o', './lib', '-c', './src'
