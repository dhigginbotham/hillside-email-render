### build files to test with ###
render = require "../lib/render"
input = require "../seed/array"

# require modules
expect = require "expect.js"
fs = require "fs"
# path = require "path"
# jade = require "jade"
_ = require "underscore"

# define this globally so we can test them individually and use them
# globally
testObject = null
template = null

describe "build a file, test it's validity, then delete it", () ->

  it "should require our dependencies", (done) ->

    expect(render).not.to.be(null)
    expect(input).not.to.be(null)
    
    done()

  it "should create a new instance of our template", (done) ->

    # build a template from our options
    template = new render 
      input: input
      fileType: "htm"

    # sync render
    template.render()

    expect(template.input.length).to.be.above(0)
    done()

  it "should build a file", (done) ->

    # async file maker from template
    template.filer (err, finished) ->
      expect(err).to.be(null)
      expect(finished).not.to.be(null)
      
      testObject = finished

      expect(testObject).not.to.be(null)
      expect(testObject.input.length).to.be.above(0)
      expect(testObject.fullName).not.to.be(null)
      expect(testObject.fullName).not.to.be(undefined)
      done()

  it "should delete our file", (done) ->
    
    fs.unlinkSync testObject.outFile

    fs.exists testObject.outFile, (exists) ->
      expect(exists).not.to.be(null)
      expect(exists).to.be(false)
      done()

