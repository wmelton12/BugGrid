class Grapher
	constructor: (@svg) ->
		@arrayOfThings = []
		@origin = [Math.round(@svg.attr('width')/2), Math.round(@svg.attr('height')/2)]
	
		box = @svg.append('rect')
				  .attr('width', '100%')
				  .attr('height', '100%')
				  .attr('stroke', 'black')
				  .attr('stroke-width','2px')
				  .attr('fill','none')
		@axes = [] 
		@axes[0] = @svg.append('line')
					  .attr('x1', 0).attr('y1', @origin[1])
					  .attr('x2', @origin[0]*2).attr('y2', @origin[1])
					  .attr('stroke', 'black')
					  .attr('stroke-width','1px')
		@axes[1] = @svg.append('line')
					  .attr('x1', @origin[0]).attr('y1', 0)
					  .attr('x2', @origin[0]).attr('y2', @origin[1]*2)
					  .attr('stroke', 'black')
					  .attr('stroke-width','1px')
	drawVector: (vec) ->
		t.remove() for t in @arrayOfThings
		@arrayOfThings = []
		
		points = [vec.getX() + @origin[0], @origin[1]-vec.getY()]

		@arrayOfThings[0] = @svg.append('line')
			.attr('x1', @origin[0])
			.attr('y1', @origin[1])
			.attr('x2', points[0])
			.attr('y2', points[1])
			.attr('stroke','red')
			.attr('stroke-width','2px')
			
	drawSingleBar: (val) ->
		t.remove() for t in @arrayOfThings
		@arrayOfThings = []
		
		@arrayOfThings[0] = @svg.append('rect')
								.attr('x',@origin[0])
								.attr('y', @origin[1] - val)
								.attr('width', 10)
								.attr('height', val)
	drawAXPlusB: (vec) ->
		@drawVector(vec)
		
		m = - (vec.x / vec.y)
		
		x1 = -@origin[0]
		y1 = @origin[1] - @evalLin(m, 0, x1)
		x1 = 0
		
		x2 = @origin[0]
		y2 = @origin[1] - @evalLin(m, 0, x2)
		x2 = @svg.attr('width')
		
		@arrayOfThings[1] = @svg.append('line')
								.attr('x1', x1)
								.attr('y1', y1)
								.attr('x2',x2)
								.attr('y2', y2)
								.attr('stroke','green')
								.attr('stroke-width','2px')
								
	evalLin : (m, d, x) ->
		return m * x + d
this.Grapher = Grapher
