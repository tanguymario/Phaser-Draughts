assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

CasePossibility = require './case-possibility.coffee'

Direction = require '../../utils/direction.coffee'

Coordinates = require '../../utils/coordinates.coffee'

class Case
  constructor: (game, board, boardCoords, gameCoords, themes) ->
    assert board?, "Board missing"
    assert boardCoords?, "Board coords missing"

    @game = game
    @board = board
    @theme = themes.cases
    @boardCoords = boardCoords
    @gameCoords = gameCoords

    @possibility = new CasePossibility @game, @, themes


  getNeighbourAt: (direction) ->
    neighbourCoords = Coordinates.Add @boardCoords, direction.value
    return @board.getCaseAtBoardCoords neighbourCoords


  setPiece: (piece) ->
    @piece = piece
    @piece.currCase = @


  removePiece: (destroy = false) ->
    if not @piece?
      return

    if destroy
      @piece.sprite.destroy()

    @piece = null


  showPossible: ->
    @possibility.showPossible()


  hidePossible: ->
    @possibility.hidePossible()



module.exports = Case
