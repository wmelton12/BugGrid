
class SystemController
	constructor: (@svg) ->
		@movers = []
		@forces = []
		@svg.append('rect')
			.attr('width', '100%')
			.attr('height', '100%')
			.attr('fill','none')
			.attr('stroke','black')
		@obs = null;
	addForce: (v) ->
		@forces[@forces.length] = v
		return @forces.length-1
	resetForces: ()->
		@forces = []
	addMover: (x,y,g1,g2) ->
		@movers[@movers.length] = new Mover(@svg,x,y,g1,g2)
		@movers[@movers.length - 1].display()
		return @movers.length - 1
	update: ()->
		i = 0
		while(i<@movers.length)
			 @updateSingle(i)
			 i++
	changeForce: (i,v) ->
		@forces[i] = v
	addObstacle: () ->
		y = Math.floor(Math.random() * @svg.attr('height'))
		x1 = Math.floor(Math.random() * @svg.attr('width'))
		range = @svg.attr('width') - x1
		x2 = Math.floor(Math.random() * range) + x1
		y = 350
		x1 = 0
		x2 = 500
		@obs = @svg.append('line')
					.attr('x1',x1)
					.attr('y1',y)
					.attr('x2',x2)
					.attr('y2',y)
					.attr('stroke','black')
		
	updateSingle: (i) ->
		@movers[i].resetForce()
		j = 0
		while j < @forces.length
			@movers[i].applyForce(@forces[j])
			j++	
		@movers[i].update()	
		@movers[i].checkEdges(@svg.attr('width'), @svg.attr('height'))
		@movers[i].display()
		@movers[i].setObstacle(@obs)
		
this.SystemController = SystemController