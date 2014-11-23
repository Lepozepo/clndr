if Meteor.isClient
	Template.calendar.helpers
		"format_date": (value) ->
			moment(value).format("MMMM")

	Template.calendar.events
		"click .CLNDR_days p": (e) ->
			console.log "Do something with:"
			console.log this



