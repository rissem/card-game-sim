@CardData = new Meteor.Collection "cardData"

if Meteor.isClient
  TextFileReader =
    read: (file, callback) ->
      reader = new FileReader

      fileInfo =
        name: file.name
        type: file.type
        size: file.size
        contents: null

      reader.onload = ->
        fileInfo.contents = reader.result
        callback(null, fileInfo)

      reader.onerror = ->
        callback(reader.error)

      reader.readAsText(file)

  Template.fileUpload.events
    "submit form" : (e, tmpl)->
      CardData.remove() #first clear everything out
      fileInput = tmpl.find('input[type=file]')
      fileList = fileInput.files
      e.preventDefault()
      for file in fileList
        TextFileReader.read file, (err, fileInfo) ->
          if err
            console.log err
          else
            window.info = fileInfo
            arrays = jQuery.csv.toArrays(fileInfo.contents)
            headers = arrays[0]
            for row in arrays[1..]
              cardData = {}
              for value,i in row
                cardData[headers[i]] = value
              CardData.insert(cardData)
            console.log info
