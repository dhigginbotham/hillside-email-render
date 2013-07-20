render = require "./lib/render"

huge = require "./seed/huge-array"

multi = new render input: huge, multiFiles: true

multi.renderMulti (err, data) ->
  console.log err if err?
  data.input = []
  data.html = []
  console.log data if data?

array = require "./seed/array"

single = new render input: array

single.singleFile (err, done) ->
  return if err? then console.log err

  ms = []
  total = 0

  for t in done.start
    ts = (t.ts - done.start[0].ts)
    ms.push(ts)
    total += ts
    console.log "#{t.place} took: #{ts}ms from start"

  console.log "you may review: #{done.outFile}"
