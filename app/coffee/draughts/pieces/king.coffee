assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Piece = require './piece.coffee'

Coordinates = require '../../utils/coordinates.coffee'

Direction = require '../../utils/direction.coffee'
DirectionUtils = require '../../utils/direction-utils.coffee'

class King extends Piece
  @R_MOVES = [
    new Coordinates -1, 0
    new Coordinates -1, -1
    new Coordinates 0, -1
    new Coordinates 1, -1
    new Coordinates 1, 0
    new Coordinates 1, 1
    new Coordinates 0, 1
    new Coordinates -1, 1
  ]


  constructor: (game, board, currCase, type, theme) ->
    super game, board, currCase, type, theme


  calculatePossibleMoves: ->
    super

    moves = @getMovesFromCoords King.R_MOVES
    @setPossibleMovesFromArray moves


module.exports = King
