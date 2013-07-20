render = require "./lib/render"

input = require "./seed/array"

template = new render input: input, multiFiles: true

template.renderMulti (err, data) ->
  console.log err if err?
  data.input = []
  data.html = []
  console.log data if data?

# template.singleFile (err, done) ->
#   return if err? then console.log err

#   ms = []
#   total = 0

#   for t in done.start
#     ts = (t.ts - done.start[0].ts)
#     ms.push(ts)
#     total += ts
#     console.log "#{t.place} took: #{ts}ms from start"

#   console.log "you may review: #{done.outFile}"
