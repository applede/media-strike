processed = 0
total = 1
Mkdir(Real_path('.') + '/../../../../../public/tvshow')
tvshow_image_folder = Real_path(Real_path('.') + '/../../../../../public/tvshow')

Meteor.methods
  scan_tvshows: ->
    console.log 'scan_tvshows'
    Scan_tvshows()
  progress: ->
    processed * 100.0 / total

@Scan_tvshows = () ->
  Tvshows.remove({})
  folders = Tvshow_folders.find({})
  folders.forEach (folder) ->
    Scan_tvshow_folder(folder.folder)

@Scan_tvshow_folder = (parent_folder) ->
  folders = Read_dir(parent_folder)
  total = folders.length
  for tvshow in folders
    if tvshow[0] != '.'
      console.log "processing #{tvshow}"
      Tvshows.insert
        folder: parent_folder
        name: tvshow
        image: poster_path(parent_folder, tvshow, tvshow_image_folder)
      processed += 1

poster_path = (parent_folder, tvshow, tvshow_image_folder) ->
  src = "#{parent_folder}/#{tvshow}/poster.jpg"
  dst = "#{tvshow_image_folder}/#{tvshow}/poster.jpg"
  if Exists(src)
    if not Exists(dst)
      Copy_file(src, dst)
    encodeURI("/tvshow/#{tvshow}/poster.jpg")
  else
    "no_image.jpg"

encode = (path) ->
  path.replace(' ', '%20')

# Router.map ->
#   this.route 'thumb',
#     where: 'server'
#     path: /^\/thumb(\/.*)$/
#     action: ->
#       folder = this.params[0]
#       file_path = "#{folder}/poster.jpg"
#       unless Exists(file_path)
#         file_path = Real_path('.') + '/../../../../../public/no_image.jpg'
#       data = Read_file(file_path)
#       this.response.writeHead 200,
#         'Content-Type': 'image'
#       this.response.write(data)
#       this.response.end()
