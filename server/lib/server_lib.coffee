fs = Npm.require 'fs'

share.is_dir = (folder) ->
  fs.statSync(folder).isDirectory()

share.real_path = (path) ->
  fs.realpathSync(path)

share.read_dir = (path) ->
  fs.readdirSync(path)
