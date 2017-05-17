assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

PieceSingleMove = require './piece-single-move.coffee'

Team = require './team.coffee'

Coordinates = require '../../utils/coordinates.coffee'

White = Team.White
Black = Team.Black

class Men extends PieceSingleMove
  @R_MOVES =
    default:
      White:
        forward_left: new Coordinates -1, -1
        forward_right: new Coordinates 1, -1
      Black:
        forward_left: new Coordinates -1, 1
        forward_right: new Coordinates 1, 1
    attack: [
      new Coordinates -1, -1
      new Coordinates 1, -1
      new Coordinates -1, 1
      new Coordinates 1, 1
    ]



  constructor: (game, board, currCase, type, theme) ->
    super game, board, currCase, type, theme


  getBestMove: ->
    bestMove = []


  calculatePossibleMoves: ->
    super

    moves = []

    tempCoords = Coordinates.Add @currCase.boardCoords, Men.R_MOVES.default[@type.team].forward_left
    moves.push @board.getCaseAtBoardCoords tempCoords
    tempCoords = Coordinates.Add @currCase.boardCoords, Men.R_MOVES.default[@type.team].forward_right
    moves.push @board.getCaseAtBoardCoords tempCoords

    @setPossibleMovesFromArray moves


module.exports = Men
