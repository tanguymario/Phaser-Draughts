assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

CanvasUtils = require '../../utils/canvas-utils.coffee'

class Piece
  @V_TIME_MOVE = 1000

  constructor: (game, board, currCase, type, themes) ->
    assert currCase?, "Current Case missing"
    assert type?, "Type missing"

    @game = game
    @board = board
    @currCase = currCase
    @type = type
    @theme = themes.pieces
    @tweenMove = null
    @possibleMoves = []

    pos = currCase.gameCoords

    # Sprite creation
    @sprite = @game.add.sprite pos.x, pos.y, @theme.key, @type.spriteFrame
    @sprite.anchor.setTo 0.5, 0.5

    # Sprite scale
    @scaleFactor = @currCase.board.caseSize / @sprite.width
    @sprite.scale.setTo @scaleFactor

    # Sprite events
    @sprite.events.onInputDown.add @downHandler, @
    @sprite.events.onInputUp.add @upHandler, @


  getMovesFromCoords: (directions) ->
    undefined # Defined in childrens


  calculatePossibleMoves: ->
    @possibleMoves = []
    undefined # Defined in childrens


  updateInput: ->
    if @type.team == @board.draughts.turn
      @enableInput()
    else
      @disableInput()


  goToCase: (caseToGo) ->
    @tweenMove = @game.add.tween(@sprite)
    @tweenMove.to( { x: caseToGo.gameCoords.x, y: caseToGo.gameCoords.y }, Piece.V_TIME_MOVE, Phaser.Easing.Exponential.Out, true)
    @tweenMove.start()


  moveTo: (caseToGo) ->
    @hidePossibilities()
    @goToCase caseToGo
    @board.draughts.onPieceMove(@, caseToGo)


  enableInput: ->
    @sprite.inputEnabled = true
    @sprite.input.enableDrag false


  disableInput: ->
    if not @sprite.inputEnabled
      return

    @sprite.input.disableDrag false
    @sprite.inputEnabled = false


  setPossibleMovesFromArray: (tempCases, checkPossible = true) ->
    for tempCase in tempCases
      if not checkPossible or @isCasePossible tempCase
        @possibleMoves.push tempCase


  hidePossibilities: ->
    for possibility in @possibleMoves
      possibility.hidePossible()


  showPossibilities: ->
    for possibility in @possibleMoves
      possibility.showPossible()


  downHandler: (sprite, event) ->
    console.log "down"
    @showPossibilities()
    if @tweenMove?
      @tweenMove.stop false


  isCasePossible: (caseToTest) ->
    if not caseToTest?
      return false

    if caseToTest.piece?
      return false

    return true


  upHandler: (sprite, event) ->
    console.log "up"

    coords = CanvasUtils.GetMouseCoordinatesInCanvas event
    caseToGo = @board.getCaseAtGameCoords coords

    if caseToGo in @possibleMoves
      @moveTo caseToGo
    else
      @moveTo @currCase


module.exports = Piece
