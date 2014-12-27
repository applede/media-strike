open_folder_dialog = (title) ->
  bootbox.dialog
    title: title
    message: "<div id='dialogNode'></div>"
    buttons:
      cancel:
        label: 'Cancel'
      do:
        label: 'Add'
        className: 'btn-primary'
        callback: ->
          folder = Session.get('current_folder')
          Meteor.call('add_tvshow_folder', folder)
  Blaze.render Template.folder_dialog, $("#dialogNode")[0]

open_confirm_dialog = (title, message, callback) ->
  bootbox.dialog
    title: title
    message: message
    buttons:
      cancel:
        label: 'Cancel'
        className: 'btn'
      ok:
        label: 'Remove'
        className: 'btn-primary'
        callback: callback

Template.settings.helpers
  tvshow_folders: ->
    share.tvshow_folders.find({})

Template.settings.events
  'click #add-folder': (event) ->
    Meteor.call 'current_folder', (error, result) ->
      Session.set('current_folder', result)
    open_folder_dialog("Choose Folder")
  'click .remove-folder': (event) ->
    folder_id = this._id
    open_confirm_dialog 'Are you sure to remove the folder from TV Shows?', this.folder, ->
      Meteor.call 'remove_tvshow_folder', folder_id



  # "click .folder-entry": (event, tmpl) ->
  #   event.stopPropagation()
  #   event.preventDefault()
  #   Session.set 'editing_folder', this._id
  #
  # "submit .new-folder": (event) ->
  #   text = event.target.text.value
  #
  #   share.folders.insert
  #     folder: text
  #
  #   event.target.text.value = ""
  #
  #   return false

# Template.folder.editing_folder = ->
#   return Session.equals('editing_folder', this._id)

Template.folder_dialog.helpers
  folders: ->
    share.folders.find {}
  current_folder: ->
    Session.get 'current_folder'
  folder_components: ->
    folder = Session.get('current_folder')
    return unless folder
    path = ''
    folder.split('/')[0..-2].map (compo) ->
      path = share.join_path(path, compo)
      { compo: compo, path: path }
  last_component: ->
    folder = Session.get('current_folder')
    return unless folder
    components = folder.split('/')
    if components.length > 0
      components[components.length - 1]
    else
      ""
  root: ->
    this.compo == ''

Template.folder_dialog.events
  'click .folder': (event) ->
    Meteor.call 'change_folder', this.folder, (error, result) ->
      Session.set('current_folder', result)
  'click .folder-component': (event) ->
    Meteor.call 'change_folder', this.path, (error, result) ->
      Session.set('current_folder', result)

Template.header.helpers
  current_route: ->
    Router.current().route.getName()
Template.menu_item.helpers
  active: (route) ->
    current_route = Router.current()
    if current_route.route.getName() == route
      "active"
    else
      ""
  path: (name) ->
    Router.pathFor(name)

Meteor.subscribe('folders')
Meteor.subscribe('tvshow_folders')

Router.configure
  layoutTemplate: 'layout'
Router.route '/',
  name: 'home'
Router.route '/tvshows',
  name: 'tvshows'
Router.route '/settings',
  name: 'settings'
