current_folder = Real_path('.')

Meteor.startup ->
  Scan_tvshows()
  fill_folders(current_folder)

  Meteor.publish "folders", ->
    Folders.find({})
  Meteor.publish "tvshow_folders", ->
    Tvshow_folders.find({})
  Meteor.publish "tvshows", ->
    Tvshows.find({})
  Meteor.publish 'trans', ->
    Trans.find({})

Meteor.methods
  current_folder: ->
    current_folder

  change_folder: (folder) ->
    if folder[0] == '/'
      new_folder = folder
    else
      new_folder = Real_path(current_folder + '/' + folder)
    if Is_dir(new_folder)
      current_folder = new_folder
      fill_folders(current_folder)
    current_folder
  add_tvshow_folder: (folder) ->
    Tvshow_folders.insert
      folder: folder
    Scan_tvshow_folder(folder)
  remove_tvshow_folder: (folder_id) ->
    Tvshow_folders.remove(folder_id)

fill_folders = (folder) ->
  Folders.remove {}
  files = Read_dir(folder)
  files[0..0] = ['..']
  for file in files
    Folders.insert
      folder: file
      is_dir: Is_dir(folder + '/' + file)
