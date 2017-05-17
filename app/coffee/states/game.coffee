Phaser = require 'Phaser'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

Draughts = require '../draughts/draughts.coffee'
DraughtsConfig = require '../draughts/config/draughts-config.coffee'

BoardConfig = require '../draughts/board/board-config.coffee'
BoardTheme = require '../draughts/board/board-theme.coffee'

CasesTheme = require '../draughts/board/cases-theme.coffee'

PiecesTheme = require '../draughts/pieces/pieces-theme.coffee'

PlayerHuman = require '../draughts/player/player-human.coffee'
PlayerAi = require '../draughts/player/player-ai.coffee'

class Game extends Phaser.State
  constructor: ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Phaser
    super

    @draughtsConfig = DraughtsConfig.classic

    @boardTheme = BoardTheme.classic
    @boardConfig = BoardConfig.russian

    @casesTheme = CasesTheme.classic
    @piecesTheme = PiecesTheme.classic


  preload: ->
    debug 'Preload...', @, 'info', 30, debugThemes.Phaser
    @game.load.image @boardTheme.key, @boardTheme.src
    @game.load.image @casesTheme.possibility.key, @casesTheme.possibility.src
    @game.load.spritesheet @piecesTheme.key, @piecesTheme.src, @piecesTheme.sprite.width, @piecesTheme.sprite.height


  create: ->
    debug 'Create...', @, 'info', 30, debugThemes.Phaser

    player1 = new PlayerHuman @game
    player2 = new PlayerAi @game

    configs = { chess: @draughtsConfig, board: @boardConfig }
    themes = { board: @boardTheme, pieces: @piecesTheme, cases: @casesTheme }

    @chess = new Draughts @game, configs, themes, player1, player2


  toggleFullscreen: ->
    if @game.scale.isFullScreen
      @game.scale.stopFullScreen()
    else
      @game.scale.startFullScreen()


module.exports = Game
