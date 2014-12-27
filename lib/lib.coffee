@Folders = new Mongo.Collection("folders")
@Tvshow_folders = new Mongo.Collection("tvshow_folders")
@Tvshows = new Mongo.Collection("tvshows")

@Join_path = (path, compo) ->
  if path.slice(-1) is '/'
    path + compo
  else
    path + '/' + compo

