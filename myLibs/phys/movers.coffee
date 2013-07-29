
class Mover
	constructor: (@svg, @x, @y, @g, @g2) -> 
		@circ = @svg.append('circle')
						.attr('cx', @x)
						.attr('cy', @y)
						.attr('r', 20)
						.attr("fill","red")
		@coll = new Collider()
		@obstacle = null
		@points = []
		@force = new Vector(0.0,0.0)
		@vel = new Vector(0.0,0.0)
		@aboveObs = false
		@its = 0
	display: () ->
			@points.push(@svg.append('circle')
				.attr('r',1)
				.attr('cx', @x)
				.attr('cy',@y)
				.attr('fill','orange'))
			@circ.attr("cx", @x)
				.attr("cy", @y)
			
			if(@points.length > 300)	
				@points[0].remove()
				@points.shift()
	setObstacle: (l) ->
		@obstacle = l
	applyForce: (v) ->
		@force = @force.add(new Vector(v.x, v.y*-1))
	resetForce: () ->
		@force = new Vector(0.0,0.0)
	update: () ->
		if(@obstacle != null)
			if(@its % 100 == 0)
				@aboveObs = @y < parseInt(@obstacle.attr('y1'))
		@vel = @vel.add(@force)
		@x += @vel.x
		@y += @vel.y
		nv = @vel.mult(20)
		nv = new Vector(nv.x, nv.y*-1)
		if @g != null then @g.drawSingleBar(nv.mag())
		if @g2 != null then @g2.drawVector(nv)
		@its++
	
	checkEdges: (w, h) ->
				
		if(@x+20 >= w)
			@x = w-20
			@vel.x*=-1
		else if(@x-20 <= 0)
			@x = 20
			@vel.x*=-1
		if(@y+20 >= h)
			@vel.y*=-1
			@y = h-20
		else if(@y-20 <= 0)
			@y = 20
			@vel.y*=-1
		if(@obstacle != null)
			if(@coll.circleAndHorizontalLine(@circ, @obstacle))	
				#console.log 'hello, there'
				@vel.y*=-1
				oy = parseInt(@obstacle.attr('y1'))
				if(@aboveObs)
					@y = oy - 20
					#alert(oy)
					#alert(@y)
					#alert(aboveObs)
				else
					@y = oy + 20
					#alert(oy)
					#alert(aboveObs)
this.Mover = Mover
