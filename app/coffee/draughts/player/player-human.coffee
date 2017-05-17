Player = require './player.coffee'

assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

class PlayerHuman extends Player

  @I_GAMEPAD_MOVE_LEFT = Phaser.Gamepad.XBOX360_DPAD_LEFT
  @I_GAMEPAD_MOVE_RIGHT = Phaser.Gamepad.XBOX360_DPAD_RIGHT
  @I_GAMEPAD_ROTATE_LEFT = Phaser.Gamepad.XBOX360_A
  @I_GAMEPAD_ROTATE_RIGHT = Phaser.Gamepad.XBOX360_B
  @I_GAMEPAD_ACCELERATE = Phaser.Gamepad.XBOX360_DPAD_DOWN
  @I_GAMEPAD_FINISH = Phaser.Gamepad.XBOX360_DPAD_UP

  constructor: (game, gamepad = null) ->
    super game

    # Add a gamepad
    if gamepad? and @game.input.gamepad.supported
      @gamepad = gamepad
      @gamepad.onDownCallback = @gamepadOnDownHandler
      @gamepad.onUpCallback = @gamepadOnUpHandler


  gamepadOnUpHandler: (button) =>
    switch button
      when PlayerHuman.I_GAMEPAD_ACCELERATE then @endAccelerate()


  gamepadOnDownHandler: (button) =>
    switch button
      when PlayerHuman.I_GAMEPAD_MOVE_LEFT then @moveLeft()
      when PlayerHuman.I_GAMEPAD_MOVE_RIGHT then @moveRight()
      when PlayerHuman.I_GAMEPAD_ROTATE_LEFT then @rotateLeft()
      when PlayerHuman.I_GAMEPAD_ROTATE_RIGHT then @rotateRight()
      when PlayerHuman.I_GAMEPAD_ACCELERATE then @startAccelerate()
      when PlayerHuman.I_GAMEPAD_FINISH then @finish()



module.exports = PlayerHuman
