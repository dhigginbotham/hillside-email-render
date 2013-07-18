# hillside-email-render
this script should take massive flat data and turn it into html chunks manageable
for hillsides internal email system.

### Usage
```md

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

  console.log "you may review: #{done.outFile}"
```

### Example Output
```md
process length: 0ms
process length: 56ms
process length: 57ms
finished in: 113ms
you may review: D:\node\hillside-email-render\output\1374182429360.html
```

### Available Options
Name | Default | Description
--- | --- | ---
`fileName` | `Date.now()` | output file name
`fileType` | `html` | output file path
`type` | `array` | `@todo`: add support for `json` and `object`
`input` | `[]` | data to render
`out` | `../output` | output path for rendered files
`template` | `../includes/template.jade` | template file to render from
`style` | `true` | inline styles with `juice`

### Tests
- run `npm test`

### License
```md
The MIT License (MIT)

Copyright (c) 2013 David Higginbotham 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
