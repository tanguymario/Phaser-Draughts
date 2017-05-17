assert = require '../utils/assert.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

Board = require './board/board.coffee'
Square = require '../utils/geometry/square.coffee'

Team = require './pieces/team.coffee'

Coordinates = require '../utils/coordinates.coffee'

class Draughts
  @V_MIN_PLAYERS = 2
  @V_MAX_PLAYERS = 2

  constructor: (game, configs, themes, players...) ->
    assert game?, "Game missing"
    assert configs?, "Configs missing"
    assert themes?, "Themes missing"
    assert players.length >= Draughts.V_MIN_PLAYERS, "Not enough players"
    assert players.length <= Draughts.V_MAX_PLAYERS, "Too much players"

    @game = game
    @config = configs.chessConfig
    @players = players

    @turn = Team.White

    # For now, we supppose that board gets all game size
    boardSize = Math.min @game.width, @game.height
    halfBoardSize = boardSize / 2

    boardTopLeftX = @game.world.centerX - halfBoardSize
    boardTopLeftY = @game.world.centerY - halfBoardSize
    boardTopLeft = new Coordinates boardTopLeftX, boardTopLeftY

    boardView = new Square boardTopLeft, boardSize
    @board = new Board @game, @, configs, themes, boardView

    @history = []


  onPieceMove: (piece, newCase) ->
    if piece.currCase == newCase
      return

    # If there's a piece, it's an ennemy!
    ennemyAttacked = newCase.piece?
    newCase.removePiece destroy
    @board.updateTeams()

    # Remove player piece from old case
    oldCase = piece.currCase
    oldCase.removePiece false

    # Piece affected to new case
    newCase.setPiece piece

    @changeTurn()

    # Update all pieces on the board
    @board.updatePieces()


  changeTurn: ->
    if @turn == Team.White
      @turn = Team.Black
    else
      @turn = Team.White



module.exports = Draughts
