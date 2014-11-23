UI.registerHelper "CLNDR", ->
	helpers

helpers =
	dates: (id) ->
		if _CLNDR and _CLNDR.active_calendars and _CLNDR.active_calendars[id]
			_CLNDR.active_calendars[id].calendar()
		else
			calendar = new CLNDR
				id:id

			calendar.calendar()

Template.body.events
	"click .CLNDR.next": (e) ->
		calendar = $(e.currentTarget).attr "clndr"

		_CLNDR.active_calendars[calendar].next()

	"click .CLNDR.previous": (e,template) ->
		calendar = $(e.currentTarget).attr "clndr"

		_CLNDR.active_calendars[calendar].previous()

	"click .CLNDR.today": (e,template) ->
		calendar = $(e.currentTarget).attr "clndr"

		_CLNDR.active_calendars[calendar].show_today()
