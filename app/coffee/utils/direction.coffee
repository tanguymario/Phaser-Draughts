Enum = require 'enum'

Coordinates = require './coordinates.coffee'

module.exports = new Enum
  'W': new Coordinates -1, 0
  'NW': new Coordinates -1, 1
  'N': new Coordinates 0, 1
  'NE': new Coordinates 1, 1
  'E': new Coordinates 1, 0
  'SE': new Coordinates 1, -1
  'S': new Coordinates 0, -1
  'SW': new Coordinates -1, -1
