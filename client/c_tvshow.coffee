Template.tvshows.helpers
  tvshows: ->
    Tvshows.find {}, {sort: ["name"]}

Template.tvshows.events
  'click #scan': (event) ->
    Meteor.call 'scan_tvshows', (error, result) ->
      console.log 'done'
