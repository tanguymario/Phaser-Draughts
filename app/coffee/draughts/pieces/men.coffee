assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Piece = require './piece.coffee'

Team = require './team.coffee'

Coordinates = require '../../utils/coordinates.coffee'

White = Team.White
Black = Team.Black

Direction = require '../../utils/direction.coffee'
DirectionUtils = require '../../utils/direction-utils.coffee'

class Men extends Piece
  @R_MOVES =
    default:
      White:
        forward_left: new Coordinates -1, -1
        forward_right: new Coordinates 1, -1
      Black:
        forward_left: new Coordinates -1, 1
        forward_right: new Coordinates 1, 1
    attack: [
      Direction.SW
      Direction.NW
      Direction.NE
      Direction.SE
    ]


  constructor: (game, board, currCase, type, theme) ->
    super game, board, currCase, type, theme


  getMovesFromCoords: (coords) ->
    tempCases = []
    for coord in coords
      tempCaseCoords = Coordinates.Add @currCase.boardCoords, coord
      tempCases.push @board.getCaseAtBoardCoords tempCaseCoords

    return tempCases


  getBestAttacks: ->
    bestAttacks = []
    possibilities = [
      {cases: [@currCase], casesAttacked: [], comingDirection: null}
    ]

    firstPossibility = true
    while possibilities.length > 0
      for possibility, index in possibilities
        possibleCases = possibility.cases
        attackedCases = possibility.casesAttacked
        lastCase = possibleCases[possibleCases.length - 1]

        if comingDirection?
          comingDirectionInverse = possibility.comingDirection.getOpposite()

        for attackDirection in Men.R_MOVES.attack
          if comingDirectionInverse? and attackDirection == comingDirectionInverse
            continue

          attackCase = lastCase.getNeighbourAt attackDirection
          if not attackCase?
            continue

          otherPiece = attackCase.piece
          if not otherPiece? or otherPiece.type.team == @type.team
            continue

          # Check that attackCase does not appear in casesAttacked
          alreadyAttacked = false
          for attackedCase in attackedCases
            if attackedCase == attackCase
              alreadyAttacked = true
              break

          if alreadyAttacked
            continue

          arriveCase = attackCase.getNeighbourAt attackDirection
          if not arriveCase? or arriveCase.piece?
            continue

          # Create a new possibility
          # TODO: Change array copy 
          newPossibility = {}
          newPossibility.cases = []
          for possibleCase in possibleCases
            newPossibility.cases.push possibleCase
          newPossibility.cases.push arriveCase

          newPossibility.casesAttacked = []
          for attackedCase in attackedCases
            newPossibility.casesAttacked.push attackedCase
          newPossibility.casesAttacked.push attackCase

          newPossibility.comingDirection = attackDirection
          console.log newPossibility
          # possibilities.push newPossibility

        if not firstPossibility
          bestAttacks.push possibility

        possibilities.splice index, 1
        firstPossibility = false

    return bestAttacks


  getBestMove: ->
    bestMove = []


  calculatePossibleMoves: ->
    super

    bestAttacks = @getBestAttacks()
    console.log bestAttacks

    moves = []

    tempCoords = Coordinates.Add @currCase.boardCoords, Men.R_MOVES.default[@type.team].forward_left
    moves.push @board.getCaseAtBoardCoords tempCoords
    tempCoords = Coordinates.Add @currCase.boardCoords, Men.R_MOVES.default[@type.team].forward_right
    moves.push @board.getCaseAtBoardCoords tempCoords

    @setPossibleMovesFromArray moves


module.exports = Men
