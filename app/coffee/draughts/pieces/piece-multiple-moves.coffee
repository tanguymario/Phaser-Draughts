assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Piece = require './piece.coffee'

Coordinates = require '../../utils/coordinates.coffee'

class PieceMultipleMoves extends Piece
  constructor: (game, board, currCase, type, theme) ->
    super game, board, currCase, type, theme


  getMovesFromCoords: (originCoords) ->
    # Deep copy
    nbCoordsPossibles = originCoords.length
    possibilities = new Array nbCoordsPossibles
    for i in [0...nbCoordsPossibles] by 1
      possibilities[i] = { index: i, coords: originCoords[i].clone() }

    tempCases = []
    while possibilities.length > 0
      i = 0
      while i < possibilities.length
        possibility = possibilities[i]
        tempCaseCoords = Coordinates.Add @currCase.boardCoords, possibility.coords
        caseAtCoords = @board.getCaseAtBoardCoords tempCaseCoords
        if @isCasePossible caseAtCoords
          tempCases.push caseAtCoords
          if caseAtCoords.piece?
            # Ennemy found
            possibilities.splice i, 1
          else
            i += 1
        else
          possibilities.splice i, 1

      for p in possibilities
        p.coords = Coordinates.Add p.coords, originCoords[p.index]

    return tempCases


module.exports = PieceMultipleMoves
