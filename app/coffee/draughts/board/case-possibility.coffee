assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

class CasePossibility extends Phaser.Sprite
  constructor: (game, currCase, themes) ->
    @game = game
    @currCase = currCase
    @themes = themes

    super @game, currCase.gameCoords.x, currCase.gameCoords.y, @themes.cases.possibility.key

    @anchor.setTo 0.5, 0.5
    @alpha = 0
    @visible = false
    @tween = null
    
    @game.add.existing(@)


  stopTween: (tween) ->
    if tween?
      tween.stop()


  showPossible: ->
    @stopTween @tween
    @alpha = 0
    @visible = true

    # Appearing
    @tween = @game.add.tween(@)
    @tween.to( {alpha: 1 }, 500, Phaser.Easing.Linear.None, true )
    @tween.start()

    # Make the tween
    @tween.onComplete.add @afterShow, @


  afterShow: ->
    @tween = @game.add.tween(@)
    @tween.to( { alpha: 0.5 }, 500, Phaser.Easing.Linear.None, true, 0, -1 )
    @tween.yoyo true, 0


  hidePossible: ->
    @stopTween @tween

    @tween = @game.add.tween(@)
    @tween.to( {alpha: 0 }, 500, Phaser.Easing.Linear.None, true )
    @tween.start()

    # @possibility.visible = false


module.exports = CasePossibility
