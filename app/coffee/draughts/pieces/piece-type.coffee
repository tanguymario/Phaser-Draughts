Men = require './men.coffee'
King = require './king.coffee'
Team = require './team.coffee'

module.exports =
  W: # Whites
    Men:
      spriteFrame: 2
      team: Team.White
      instance: Men
    King:
      spriteFrame: 3
      team: Team.White
      instance: King
  B: # Blacks
    Men:
      spriteFrame: 0
      team: Team.Black
      instance: Men
    King:
      spriteFrame: 1
      team: Team.Black
      instance: King
