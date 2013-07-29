class Inputer
	constructor: (loc) ->
		@draw = d3.select(loc)
		@form = @draw.append('form')
		@numElements = 0
		@els = []
		@buttons = []
		
	createTextField: (name, val) ->
		currentPos = @els.length
		@els[currentPos] = @form.append('input')
								 .attr('type', 'text')
								 .attr('name', name)
								 .attr('value', val)
								 .attr('id', ''+currentPos)
		return currentPos
	createLabel: (text) ->
		@form.append('text')
			.text(text)
	getTextField: (ind) ->
		return $('#' + ind).val()
	getNewButton: () ->
		currentPos = @buttons.length
		@buttons[currentPos] = @form.append('input')
									.attr('type','button')
		return @buttons[currentPos]
this.Inputer = Inputer