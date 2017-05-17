assert = require '../assert.coffee'

Direction = require '../direction.coffee'

class Matrix
  @DEFAULT_SIZE = 4
  @NB_BORDERS = 4

  @GetDoubleArrayCopy: (tab) ->
    assert Array.isArray tab, "Tab not an array"
    assert Array.isArray tab[0], "Tab not a double array"

    height = tab.length
    newArr = new Array tab
    for i in [0...height] by 1
      width = tab[i].length
      newArr[i] = new Array width
      for j in [0...width] by 1
        newArr[i][j] = tab[i][j]

    return newArr


  @Identity: (size = Matrix.DEFAULT_SIZE) ->
    identity = new Array size
    for i in [0...size] by 1
      identity[i] = new Array size
      for j in [0...size] by 1
        identity[i][j] = if i == j then 1 else 0

    return new Matrix identity


  @Add: (matA, matB) ->
    assert matA.width == matB.width, "Not same width"
    assert matA.height == matB.height, "Not same height"

    result = new Array matA.height
    for i in [0...matA.height.length] by 1
      result[i] = new Array matA.width
      for j in [0...matA.width] by 1
        result[i][j] = matA.tab[i][j] + matB.tab[i][j]

    return new Matrix result


  @Mult: (matA, matB) ->
    assert matA.width == matB.width, "Not same width"
    assert matA.height == matB.height, "Not same height"

    # TODO
    throw "Not Implemented"


  constructor: (tab, copy = false) ->
    assert Array.isArray tab
    assert tab.length >= 0, "Array size cannot be negative"
    assert tab[0].length >= 0, "Double array size cannot be negative"

    @height = tab.length
    @width = tab[0].length

    for i in [0...@height] by 1
      assert tab[i].length == @width, "Matrix width differences found!"

    if copy
      @tab = Matrix.GetDoubleArrayCopy tab
    else
      @tab = tab


  getAt: (i, j) ->
    assert i >= 0 and i < @width, "Column out of bounds"
    assert j >= 0 and j < @height, "Line out of bounds"
    return @tab[j][i]


  getTransposition: ->
    newMatrix = @clone()
    newMatrix.setTransposition()
    return newMatrix


  setTransposition: ->
    if @width == @height
      for i in [1...@height] by 1
        for j in [0...i] by 1
          temp = @tab[i][j]
          @tab[i][j] = @tab[j][i]
          @tab[j][i] = temp
    else
      newMatrix = new Array @width
      for i in [0...@width] by 1
        newMatrix[i] = new Array @height
        for j in [0...@height] by 1
          newMatrix[i][j] = @tab[j][i]

      @matrix = newMatrix
      @height = newMatrix.length
      @width = newMatrix[0].length


  getRotation: (direction) ->
    newMatrix = @clone()
    newMatrix.rotate angle
    return newMatrix


  setRotation: (direction) ->
    if direction == Direction.N
      return

    if @width != @height
      throw "Not Implemented"

    switch direction
      when Direction.E then @rotateRight()
      when Direction.W then @rotateLeft()
      when Direction.S then @rotateBack()
      else throw "Angle must be 90, 180 or 270"


  rotateRight: ->
    halfHeight = Math.trunc @height / 2
    for depth in [0...halfHeight] by 1
      nbCasesToDo = @height - 1 - depth * 2
      nbCasesToDoDepth = nbCasesToDo + depth
      for i in [0...nbCasesToDo] by 1
        nbCasesLeft = nbCasesToDo - i
        nbCasesLeftDepth = nbCasesLeft + depth

        incrementalDepth = i + depth

        # Get cell values
        firstCell = @tab[depth][incrementalDepth]
        secondCell = @tab[incrementalDepth][nbCasesToDoDepth]
        thirdCell = @tab[nbCasesToDoDepth][nbCasesLeftDepth]
        fourthCell = @tab[nbCasesLeftDepth][depth]

        # Swap values
        @tab[incrementalDepth][nbCasesToDoDepth] = firstCell
        @tab[nbCasesToDoDepth][nbCasesLeftDepth] = secondCell
        @tab[nbCasesLeftDepth][depth] = thirdCell
        @tab[depth][incrementalDepth] = fourthCell


  rotateLeft: ->
    halfHeight = Math.trunc @height / 2
    for depth in [0...halfHeight] by 1
      nbCasesToDo = @height - 1 - depth * 2
      nbCasesToDoDepth = nbCasesToDo + depth
      for i in [0...nbCasesToDo] by 1
        nbCasesLeft = nbCasesToDo - i
        nbCasesLeftDepth = nbCasesLeft + depth

        incrementalDepth = i + depth

        # Get cell values
        firstCell = @tab[depth][incrementalDepth]
        secondCell = @tab[nbCasesLeftDepth][depth]
        thirdCell = @tab[nbCasesToDoDepth][nbCasesLeftDepth]
        fourthCell = @tab[incrementalDepth][nbCasesToDoDepth]

        # Swap values
        @tab[nbCasesLeftDepth][depth] = firstCell
        @tab[nbCasesToDoDepth][nbCasesLeftDepth] = secondCell
        @tab[incrementalDepth][nbCasesToDoDepth] = thirdCell
        @tab[depth][incrementalDepth] = fourthCell


  # TODO
  rotateBack: ->
    halfheight = Math.trunc @height / 2
    for i in [0...@height] by 1
      nbCasesToDo = @width - i
      bottomLine = nbCasesToDo - 1
      for j in [0...nbCasesToDo] by 1
        rightColumn = @width - 1 - j

        # Swap
        temp = @tab[i][j]
        @tab[i][j] = @tab[bottomLine][rightColumn]
        @tab[bottomLine][rightColumn] = temp


  flipHorizontally: ->
    halfWidth = Math.trunc @width / 2
    for i in [0...@height] by 1
      for j in [0...halfWidth] by 1
        rightColumn = @width - 1 - j

        # Swap values
        temp = @tab[i][j]
        @tab[i][j] = @tab[i][rightColumn]
        @tab[i][rightColumn] = temp


  flipVertically: ->
    halfHeight = Math.trunc @height / 2
    for i in [0...halfHeight] by 1
      bottomLine = @height - 1 - i
      for j in [0...@height] by 1
        # Swap values
        temp = @tab[i][j]
        @tab[i][j] = @tab[bottomLine][j]
        @tab[bottomLine][j] = temp


  clone: ->
    cloneMatrix = Matrix.GetDoubleArrayCopy @tab
    return new Matrix cloneMatrix


  toString: ->
    return """
    Matrix :
      - width: #{@width}
      - height: #{@height}
      - tab:
    #{
    tabString = ""
    for i in [0...@height] by 1
      for j in [0...@width] by 1
        tabString += @tab[i][j].toString() + " "
      tabString += "\n"
    tabString
    }
    """


module.exports = Matrix
