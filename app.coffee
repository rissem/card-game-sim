if Meteor.isClient
  TextFileReader =
    read: (file, callback) ->
      reader = new FileReader

      fileInfo =
        name: file.name
        type: file.type
        size: file.size
        file: null

      reader.onload = ->
        fileInfo.file = reader.result
        callback(null, fileInfo)

      reader.onerror = ->
        callback(reader.error)

      reader.readAsText(file)

  Template.fileUpload.events
    "submit form" : (e, tmpl)->
      fileInput = tmpl.find('input[type=file]')
      fileList = fileInput.files
      e.preventDefault()
      for file in fileList
        TextFileReader.read file, (err, fileInfo) ->
          if err
            console.log err
          else
            console.log fileInfo
          