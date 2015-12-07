module.exports = class Animator

  step: 0
  frameRef: []
  fps: 50
  interval: null
  onLoad: null

  constructor: ($cont, onLoad) ->
    self = @
    @$cont = $cont
    @$ani = $cont.find 'div'
    @bg = @$ani.css 'background-position'
    @onLoad = onLoad

    img = @$ani.css('background-image')
    img = img.match(/\((.*?)\)/)[1].replace(/('|")/g,'')

    $.ajax
      url: img
      context: @
      success: ->
        $.ajax
          url: '/assets/paths/' + $cont.data('json')
          success: @setup
          context: @



  setup: (res) ->
    @json = res

    @frameRef = _.sortBy _.keys res.frames, (name) ->
      return name
    @frameRef.pop()

    @render()

    if @onLoad?
      @onLoad()

  animate: (from, to, onEnd)->
    self = @
    if from?
      @step = from
      
    @interval = setInterval ->
      self.render.call(self)

      if to? && self.step == to
        if typeof onEnd == 'function'
          self.stop()
          onEnd()
        else
          self.step = from - 1

      if ++self.step >= self.frameRef.length
        self.step = 0
      
    , @fps

  stop: ->
    clearInterval @interval
    @interval = null

  render: ->

    frame = @json.frames[@frameRef[@step]].textureRect
    offset = @json.frames[@frameRef[@step]].spriteOffset
    @$ani.css
      width: frame[1][0] + 'px'
      height: frame[1][1] + 'px'
      backgroundPosition: -frame[0][0] + 'px ' + -frame[0][1] + 'px'
      marginLeft: -offset[0] + 'px'
      marginTop: -offset[1] + 'px'
      backgroundImage: "url(#{@bg})"
  
