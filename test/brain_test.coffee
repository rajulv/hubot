assert = require 'assert'
Robot  = require '../src/robot'

saved   = false
closing = false
closed  = false

brain = new Robot.Brain

brain.on 'save', (data) ->
  is_closing = closing
  saved = closing = true
  brain.close() if !is_closing
  assert.equal 1, data.abc

brain.on 'close', ->
  closed = true

brain.data.abc = 1
brain.resetSaveInterval 0.1

process.on 'exit', ->
  assert.ok saved
  assert.ok closed

