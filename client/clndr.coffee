@_CLNDR =
	active_calendars: {}

class @CLNDR
	constructor: (data={}) ->
		#data.id = Unique identifier (no spaces allowed!), used to get data from it later
		#data.month
		#data.year
		#data.display_days = How many days to show (default:42)
		#data.indent = On which weekday to indent (default:6 [0-6] where 0 is Sunday)

		@id = data.id
		_CLNDR.active_calendars["#{@id}"] = this

		@days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
		@months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
		@days_per_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
		@today = new Date()
		@month = new ReactiveVar data.month or @today.getMonth()
		@year = data.year or @today.getFullYear()
		@display_days = data.display_days or 42
		@indent = data.indent or 6

	day_of_month: (data={day:1}) ->
		if not data.month and data.month isnt 0
			data.month = @month.get()

		day = new Date @year,data.month,data.day
		day.getDay()

	days_of_month: (month) ->
		if not month and month isnt 0
			month = @month.get()

		if month is 1 and (((@year % 4 is 0) and (@year % 100 isnt 0)) or @year % 400 is 0)
			29
		else
			@days_per_month[month]

	calendar: ->
		cal = []
		#previous month last week
		first_weekday = @day_of_month
			day:1

		if first_weekday isnt 0
			for day in [1..@day_of_month()]
				weekday = @day_of_month
					month: @month.get() - 1
					day: @days_per_month[@month.get()-1] - ((@day_of_month())-day)

				indent = if weekday is @indent then true else false

				cal.push
					position: day
					weekday: weekday
					day: @days_per_month[@month.get()-1] - ((@day_of_month())-day)
					previous_month:true
					indent: indent

		#this month
		for day in [1..@days_of_month()]
			weekday = @day_of_month
				day:day

			indent = if weekday is @indent then true else false

			cal.push
				position: day + @day_of_month()
				weekday: weekday
				day: day
				current_month:true
				indent: indent

		#next month first week
		cal_length = cal.length
		for day in [1..(@display_days - cal_length)]
			weekday = @day_of_month
				month: @month.get() + 1
				day:day

			indent = if weekday is @indent then true else false

			cal.push
				position:cal_length + day
				weekday:weekday
				day:day
				next_month:true
				indent: indent

		cal

	next: ->
		current_month = @month.get()
		if current_month isnt 11
			@month.set(current_month + 1)
		else
			@month.set 0

	previous: ->
		current_month = @month.get()
		if current_month isnt 0
			@month.set(current_month - 1)
		else
			@month.set 11

	show_today: ->
		todays_month = @today.getMonth()
		@month.set todays_month




