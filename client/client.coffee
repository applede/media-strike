openFolderDialog = (fs) ->
  bootbox.dialog
    title: 'Choose Folder',
    message: "<div id='dialogNode'></div>"
    buttons:
      do:
        label: "Add",
        className: "btn btn-primary"
        callback: ->
          console.log "ok"
  Blaze.render Template.folderDialog, $("#dialogNode")[0]

Template.body.helpers
  folders: ->
    return Folders.find {}

# Template.folder.editing_folder = ->
#   return Session.equals('editing_folder', this._id)

Template.folderDialog.helpers
  folders: ->
    return Folders.find {}
  currentFolder: ->
    return "/Users"

Template.body.events
  "click #add-folder": (event) ->
    openFolderDialog "Choose Folder"

  "click .folder-entry": (event, tmpl) ->
    event.stopPropagation()
    event.preventDefault()
    Session.set('editing_folder', this._id)

  "submit .new-folder": (event) ->
    text = event.target.text.value

    Folders.insert
      folder: text

    event.target.text.value = ""

    return false
