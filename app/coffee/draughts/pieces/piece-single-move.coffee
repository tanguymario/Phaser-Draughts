assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Piece = require './piece.coffee'

Coordinates = require '../../utils/coordinates.coffee'

class PieceSingleMove extends Piece
  constructor: (game, board, currCase, type, theme) ->
    super game, board, currCase, type, theme


  getAttacksFromCoords: (coords) ->
    bestAttackMoves = []
    for 


  getMovesFromCoords: (coords) ->
    tempCases = []
    for coord in coords
      tempCaseCoords = Coordinates.Add @currCase.boardCoords, coord
      tempCases.push @board.getCaseAtBoardCoords tempCaseCoords

    return tempCases


module.exports = PieceSingleMove
