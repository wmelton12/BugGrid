# requires JQuery
# requires d3
# requires Vector
# requires browser svg support
# svg must have an id
class VectorInputer
	constructor: (@svg) ->
		@xPos = @svg.attr('x')
		@yPos = @svg.attr('y')
		@box = @svg.append('rect')
					.attr('width','100%')
					.attr('height','100%')
					.attr('fill','none')
					.attr('stroke','black')
					.attr('stroke-width','1px')
		@scaleX = d3.scale.linear()
					.domain([-@svg.attr('width')/2, @svg.attr('width')/2])
					.range([-@svg.attr('width')/2, @svg.attr('width')/2])
		@scaleY = d3.scale.linear()
					.domain([-@svg.attr('height')/2, @svg.attr('height')/2])
					.range([@svg.attr('height')/2, -@svg.attr('height')/2])
		@origin = [ @svg.attr('width')/2, @svg.attr('height')/2]
		@label = @svg.append('text')
				.attr('x',6)
				.attr('y',11)
		@axes = [] # xaxis, yaxis
		@axes[0] = @svg.append('line')
						.attr('x1', 0)
						.attr('y1', @origin[1])
						.attr('x2', @svg.attr('width'))
						.attr('y2', @origin[1])
						.attr('stroke','black')
		@axes[1] = @svg.append('line')
						.attr('x1', @origin[0])
						.attr('y1', 0)
						.attr('x2', @origin[0])
						.attr('y2', @svg.attr('width'))
						.attr('stroke','black')
		@line = @svg.append('line')
		@svgpoint = @svg.append('circle').attr('r',0)
		@point = []
	
		
		$('#'+@svg.attr('id')).mousedown( (e)=>
			
			x = e.pageX - @xPos
			y = e.pageY - @yPos
			@point = [x - @origin[0],@origin[1] - y]
			@line.remove()
			@svgpoint.remove()
			@svgpoint = @svg.append('circle')
						 .attr('r',4)
						 .attr('cx',x)
						 .attr('cy',y)
						 .attr('fill','black')
			@line = @svg.append('line')
						.attr('x1', @origin[0])
						.attr('y1', @origin[1])
						.attr('x2',x)
						.attr('y2',y)
						.attr('stroke','red')
		)
	drawLabel: (x) ->
		@label.text(x)
			
	setScaleX: (toSet) -> @scaleX.range(toSet)
	setScaleY: (toSet) -> @scaleY.range(toSet)
	getMostRecentPointAsVector: () ->
		if @point.length!=0
			return new Vector(@scaleX(@point[0]),@scaleY(@point[1]))
		else 
			return new Vector(0,0)
this.VectorInputer = VectorInputer