"use strict"

render = require "./lib/render"

input = require "./seed/array"

template = new render input: input

template.render()

template.filer (err, done) ->
  return if err? then console.log err
  ms = []
  total = 0
  for t in done.start
    ts = (t - done.start[0])
    ms.push(ts)
    total += ts
    console.log "process length: #{ts}ms"

  console.log "finished in: #{total}ms"