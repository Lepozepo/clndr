if Meteor.isClient
	Template.calendar.helpers
		"format_date": (value) ->
			moment(value).format("MMMM YYYY")

		"selected_date": ->
			Session.get "calendar.selected_date"

	Template.calendar.events
		"click .CLNDR_days p": (e) ->
			console.log "Do something with:"
			console.log this
			Session.set "calendar.selected_date",moment(@date).format "ll"


