Template.body.helpers
  folders: ->
    return Folders.find {}

Template.body.events
  "submit .new-folder": (event) ->
    text = event.target.text.value

    Folders.insert
      folder: text

    event.target.text.value = ""

    return false
