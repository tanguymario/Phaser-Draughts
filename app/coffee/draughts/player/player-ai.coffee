Player = require './player.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

class PlayerAi extends Player
  constructor: (game) ->
    super game


module.exports = PlayerAi
