"use strict"

fs = require "fs"
path = require "path"
jade = require "jade"
juice = require "juice"
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

  # default template to use, so you don't have to 
  # define a bunch of `unecessary stuff`
  @template = path.join __dirname, "..", "includes", "template.jade"
  
  # default style to use for inlining css w/ `juice`
  @style = path.join __dirname, "..", "includes", "style.css" #"style.css" # 

  # extend our `opts` if they're there
  if opts? then _.extend @, opts

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
  render = jade.compile fs.readFileSync self.template, "utf8"

  @html = render self

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

renderHandler::filer = (fn) ->

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

renderHandler::juice = (fn) ->
  
  self = @

  juice.juiceContent @html, { url: @style }, (err, html) ->
    return if err? then fn err, null

    fs.unlink self.outFile, (err) ->
      return if err? then fn err, null

      fs.writeFile self.outFile, html, (err) ->
        return if err? then fn err, null

        self.start.push 
          ts: Date.now()
          place: "juice"        


        fn null, self

    
module.exports = renderHandler