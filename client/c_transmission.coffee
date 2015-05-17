Template.transmission.helpers
  trans: ->
    Trans.find({})

Template.transmission.events
  'click #refresh': (event) ->
    Meteor.call 'refresh_transmission', (error, result) ->
      #
  'click #process': (event) ->
    Meteor.call 'process_transmission', (error, result) ->
      #
