@exampleCardHandles = ["blue", "green", "red", "red", "red"]

@crunchHand = (cardHandles) ->
  sum = 0
  totalNumber = 6 * cardHandles.length
  for cardHandle in cardHandles
    console.log "Cardhandle", cardHandle
    card = CardData.findOne {handle: cardHandle}
    console.log("CARD", card)
    for i in [1..6]
      console.log "#{cardHandle}: #{i}"
      console.log "Card value", JSON.stringify card["value#{i}"]
      val = card["value#{i}"]
      console.log "Val", val
      sum += parseInt val, 10
  mean = sum*1.0/totalNumber
  console.log "AVG HAND VALUE", mean

