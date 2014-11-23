@_CLNDR =
	active_calendars: {}
	reactive_calendars: new ReactiveVar {}

helpers =
	dates: (id) ->
		if _CLNDR and _CLNDR.active_calendars and _CLNDR.active_calendars[id]
			_CLNDR.active_calendars[id].calendar()
		else
			calendar = new CLNDR
				id:id

			calendar.calendar()

	find: ->
		_CLNDR.reactive_calendars.get()

UI.registerHelper "CLNDR", ->
	helpers

Template.body.events
	"click .CLNDR_next": (e) ->
		calendar = $(e.currentTarget).attr "clndr"

		_CLNDR.active_calendars[calendar].next()

	"click .CLNDR_previous": (e) ->
		calendar = $(e.currentTarget).attr "clndr"

		_CLNDR.active_calendars[calendar].previous()

	"click .CLNDR_today": (e) ->
		calendar = $(e.currentTarget).attr "clndr"

		_CLNDR.active_calendars[calendar].show_today()


