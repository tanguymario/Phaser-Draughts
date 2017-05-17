module.exports =
  between: (min, max) ->
    return min + Math.random() * (max - min)
