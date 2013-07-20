"use strict"

fs = require "fs"
path = require "path"
jade = require "jade"
_ = require "underscore"

### renderHandler ###
# will take massive objects and have muchos fun with their insides

renderHandler = (opts) ->

  now = Date.now()

  # if our filename isn't custom,
  # append `Date.now()`
  @fileName = now

  # output type, ".html, .htm, .aspx, etc"
  @fileType = "html"

  # future work here, so we can support `json`, `array`, `object`
  @type = "array" 

  # default output directory, so you don't **have**
  # to set one.
  @out = path.join __dirname, "..", "output"

  # data, assumed to be objects, we will add a parser
  # for json after the first proof of concept is approved
  @input = []

  # we default with creating a single file, setting
  # `multiFiles` to `true` will give you multiple files
  # instead of the default large one
  @multiFiles = false

  @template = path.join __dirname, "..", "includes", "single.jade"
  # default style to use for inlining css w/ `juice`
  @style = path.join __dirname, "..", "includes", "style.css" #"style.css" # 

  # extend our `opts` if they're there
  if opts? then _.extend @, opts

  # default template to use, so you don't have to 
  # define a bunch of `unecessary stuff`

  @template = path.join __dirname, "..", "includes", if @multiFiles == false then "single.jade" else "multi.jade"
  
  # join our file, output together
  @fullName = "#{@fileName}.#{@fileType}"

  # stats/timer so we can see how long this takes
  @start = []
  @start.push 
    ts: now
    place: "init"

  # return our the whole object, so we can do stuff later with it
  @

renderHandler::render = (fn) ->

  # broke this into a prototype to give us a little
  # more control of our scope
  
  self = @

  # render function, so when we do `new renderHandler` this gets
  # fired once, and not a bunch of other times, we'll also clean
  # this out of memory near immediately
  _jadeTemplate = fs.readFileSync(self.template, "utf8")

  opts =
    pretty: true

  @render = jade.compile _jadeTemplate, opts

  # pass it the whole object, we can
  # make cool stuff with that!
  @html = @render self

  # push the time it took to run the `render fn`
  @start.push 
    ts: Date.now()
    place: "render"

  # give callback strategy if its needed,
  # massive data and async, with single threads
  # gives us this idea.
  if _.isFunction fn
    fn null, @
  else
    @

renderHandler::renderMulti = (fn) ->

  opts =
    pretty: true
  
  self = @

  _jadeTemplate = fs.readFileSync(self.template, "utf8")

  console.log self.input.length

  for data in self.input 

    _render = jade.compile _jadeTemplate, opts
    __html = _render data
    ts = Date.now()

    # create the full output path and fileName 
    outFile = path.join self.out, "#{ts}.#{self.fileType}"

    # call `fs.writeFile` and have tons of fun
    fs.writeFile outFile, __html, (err) ->
      return if err? then fn err, null
      # push the time it took to run `fs.writeFile`

  # give callback strategy if its needed,
  # massive data and async, with single threads
  # gives us this idea.
  
  if _.isFunction fn
    fn null, @
  else
    @

renderHandler::singleFile = (fn) ->

  # set @input back to an empty array, keep
  # out footprint small'ish
  # @input = []

  # filer method will do what it sounds like,
  # become your personal secretary and place these
  # files, `callback fn` required

  # keep track of our scope
  self = @

  # create the full output path and fileName 
  self.outFile = path.join self.out, self.fullName

  # call `fs.writeFile` and have tons of fun
  fs.writeFile self.outFile, self.html, (err) ->
    return if err? then fn err, null
    # push the time it took to run `fs.writeFile`
    
    self.start.push 
      ts: Date.now()
      place: "filer"

    fn null, self
    
module.exports = renderHandler