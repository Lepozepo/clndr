class @CLNDR
	constructor: (data={}) ->
		#data.id = Unique identifier (alphanumeric only), used to get data from it later
		#data.month
		#data.year
		#data.display_days = How many days to show (default:42)
		#data.indent = On which weekday to indent (default:6 [0-6] where 0 is Sunday)

		@id = data.id
		_CLNDR.active_calendars["#{@id}"] = this
		_CLNDR.reactive_calendars.set _CLNDR.active_calendars

		@days_per_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
		@display_days = data.display_days or 42
		@indent = data.indent or 6

		@today = new Date()
		@month = new ReactiveVar data.month or @today.getMonth()
		@year = data.year or @today.getFullYear()

	day_of_month: (data={day:1}) ->
		if not data.month and data.month isnt 0
			data.month = @month.get()

		if not data.year and data.year isnt 0
			data.year = @year

		day = new Date data.year,data.month,data.day
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

		if first_weekday isnt 0 #Don't calculate if the month begins on a Sunday
			for day in [1..@day_of_month()]
				if @month.get() is 0 #Calculate last year if first month
					year = @year - 1
					month = 11
					day_number = 31 - (@day_of_month() - day)
				else
					year = @year
					month = @month.get()-1
					day_number = @days_per_month[@month.get()-1] - (@day_of_month()-day)

				weekday = @day_of_month
					year: year
					month: month
					day: day_number

				indent = if weekday is @indent then true else false

				cal.push
					position: day
					weekday: weekday
					day: day_number
					previous_month:true
					indent: indent
					date:new Date year,month,day_number

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
				date:new Date @year,@month.get(),day

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
				date:new Date @year,(@month.get()+1),day
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

	current_month: ->
		new Date @year,@month.get()


