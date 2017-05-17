Direction = require './direction.coffee'

N = Direction.N
NE = Direction.NE
E = Direction.E
SE = Direction.SE
S = Direction.S
SW = Direction.SW
W = Direction.W
NW = Direction.NW

module.exports =
  toCanvasDirection: (direction) ->
    direction.y *= -1
    return direction


  getOpposite: (direction) ->
    switch direction
      when N then return S
      when NE then return SW
      when E then return W
      when SE then return NW
      when S then return N
      when SW then return NE
      when W then return E
      when NW then return SE
      else return N


  # 90° left
  getLeft: (direction) ->
    switch direction
      when N then return W
      when NE then return NW
      when E then return N
      when SE then return NE
      when S then return E
      when SW then return SE
      when W then return S
      when NW then return SW
      else return N


  getRight: (direction) ->
    switch direction
      when N then return E
      when NE then return SE
      when E then return S
      when SE then return SW
      when S then return W
      when SW then return NW
      when W then return N
      when NW then return NE
      else return N
