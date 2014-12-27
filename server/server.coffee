current_folder = share.real_path('.')

Meteor.startup ->
  fill_folders(current_folder)

  Meteor.publish "folders", ->
    share.folders.find({})
  Meteor.publish "tvshow_folders", ->
    share.tvshow_folders.find({})

Meteor.methods
  folders: ->
    ["a", "b"]

  current_folder: ->
    current_folder

  change_folder: (folder) ->
    if folder[0] == '/'
      new_folder = folder
    else
      new_folder = share.real_path(current_folder + '/' + folder)
    if share.is_dir(new_folder)
      current_folder = new_folder
      fill_folders(current_folder)
    current_folder
  add_tvshow_folder: (folder) ->
    share.tvshow_folders.insert
      folder: folder
  remove_tvshow_folder: (folder_id) ->
    share.tvshow_folders.remove(folder_id)

fill_folders = (folder) ->
  share.folders.remove {}
  files = share.read_dir(folder)
  files[0..0] = ['..']
  for file in files
    is_dir = share.is_dir(folder + '/' + file)
    share.folders.insert
      folder: file
      is_dir: is_dir

