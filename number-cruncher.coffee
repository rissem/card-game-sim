@crunchHand = (cardHandles) ->
  cards = _.map cardHandles, (handle)->
    CardData.findOne {handle}
  scores = _.map [1..10000], ()->
    roll = @rollHand(cards)
    @computeScore(@rollHand(cards))
  @calculateMeanStdDev (scores)
  #easy way to draw this in scatterplot?

@rollHand = (cards)->
  _.map cards, (card)->
    rand = Math.ceil(Math.random()*6)
    parseInt(card["value#{[rand]}"])

@computeScore = (roll)->
  sum(roll)

@calculateMeanStdDev = (scores)->
  mean = 1.0*sum(scores) / scores.length
  console.log "MEAN", mean
  Session.set "mean", mean

  squareSum = _.reduce scores, (memo, num) ->
    memo + Math.pow((num - mean),2)
  ,0
  console.log "SQUARE SUM", squareSum
  stdDev = Math.sqrt(1.0*squareSum/scores.length)
  console.log "standard deviation", stdDev
  Session.set "stdDev", stdDev
  
@sum = (arr)->
  _.reduce arr, (memo, num)->
    memo + num
  ,0  