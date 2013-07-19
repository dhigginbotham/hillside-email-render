render = require "./lib/render"

input = require "./seed/huge-array"

template = new render input: input

template.render()

template.filer (err, done) ->
  return if err? then console.log err

  ms = []
  total = 0

  for t in done.start
    ts = (t.ts - done.start[0].ts)
    ms.push(ts)
    total += ts
    console.log "#{t.place} took: #{ts}ms from start"

  console.log "you may review: #{done.outFile}"
