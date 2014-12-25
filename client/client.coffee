Session.setDefault "counter", 0

Template.hello.helpers
  counter: ->
    return Session.get("counter")

Template.hello.events
  'click button': ->
    Session.set("counter", Session.get("counter") + 1)

Template.body.events
  "submit .new-task": (event) ->
    text = event.target.text.value

    event.target.text.value = ""

    return false
