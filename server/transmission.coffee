Meteor.methods
  refresh_transmission: ->
    Refresh_trans()
  process_transmission: ->
    Process_all_trans()

@Refresh_trans = ->
  Trans.remove({})
  Exec "transmission-remote --list", (error, stdout, stderr) ->
    lines = stdout.toString().split("\n")
    for line in lines
      Trans.insert
        tid: line[0..3]
        name: line[70..-1]
        status: Trim(line[57..66])
        ratio: line[50..55]
        size: line[14..21]
  return

@Process_all_trans = ->
  stop = false
  Trans.find({}).forEach (trans) ->
    if not stop and trans.status == 'Finished'
      process_trans(trans)
      stop = true
  return

process_trans = (trans) ->
  location = find_location(trans.tid)
  src = "#{location}/#{trans.name}"
  if Is_dir(src)
    process_directory(src)
  #

process_directory = (src_dir) ->
  for file in Read_dir(src_dir)
    console.log file

find_location = (tid) ->
  fut = new Future()
  Exec "transmission-remote --torrent #{tid} --info", (error, stdout, stderr) ->
    for line in stdout.split("\n")
      re = /^  Location: (.+)$/.exec(line)
      if re
        fut.return(re[1])
        break
  fut.wait()
