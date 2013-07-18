render = require "./lib/render"

input = require "./seed/small-array"

template = new render input: input

template.render()

template.filer (err, done) ->
  return if err? then console.log err
  
  # ms = []
  # total = 0

  # for t in done.start
  #   ts = (t - done.start[0])
  #   ms.push(ts)
  #   total += ts
  #   console.log "process length: #{ts}ms"

  # console.log "finished in: #{total}ms"


  template.juice (err, juiced) ->
    if err? then console.log err
    console.log "you may review: #{juiced.outFile}"
