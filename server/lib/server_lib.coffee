@Fs = Npm.require('fs')
@Exec = Meteor.wrapAsync(Npm.require('child_process').exec)
@Spawn = Npm.require('child_process').spawn
@Future = Npm.require('fibers/future')

@Is_dir = (folder) ->
  Fs.statSync(folder).isDirectory()

@Real_path = (path) ->
  Fs.realpathSync(path)

@Read_dir = (path) ->
  Fs.readdirSync(path)

@Exists = (path) ->
  Fs.existsSync(path)

@Read_file = (path) ->
  Fs.readFileSync(path)

@Copy_file = (src, dst) ->
  console.log("copying #{src} to #{dst}")
  dst_folder = dst.split('/')[0..-2].join('/')
  Mkdir(dst_folder)
  data = Fs.readFileSync(src)
  Fs.writeFileSync(dst, data)

  # Exec "mkdir -p '#{dst_folder}'", (error, stdout, stderr) ->
  #   if error
  #     console.log('stdout: ' + stdout)
  #     console.log('stderr: ' + stderr)
  #     console.log('error: ' + error)
  #   else
  #     data = Fs.readFileSync(src)
  #     Fs.writeFileSync(dst, data)

@Mkdir = (path) ->
  Exec("mkdir -p '#{path}'")
  # Exec "mkdir -p '#{path}'", (error, stdout, stderr) ->
  #   if error
  #     console.log('stdout: ' + stdout)
  #     console.log('stderr: ' + stderr)
  #     console.log('error: ' + error)
  #   else
  #     callback.call()
