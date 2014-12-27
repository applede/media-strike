share.folders = new Mongo.Collection("folders");
share.tvshow_folders = new Mongo.Collection("tvshow_folders");

share.join_path = (path, compo) ->
  if path.slice(-1) is '/'
    path + compo
  else
    path + '/' + compo

