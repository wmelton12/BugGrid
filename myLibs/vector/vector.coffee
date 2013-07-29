class Vector
	constructor: (@x,@y) ->
	getY: ()-> return @y
	getX: ()-> return @x
	add: (v) ->
		nx = @x + v.x
		ny = @y + v.y
		return new Vector(nx,ny)
	sub: (v) ->
		nx = @x - v.x
		ny = @y - v.y
		return new Vector(nx, ny)
	clone: () ->
		nx = @x
		ny = @y
		return new Vector(@x, @y)
	mult: (m) ->
		nx = @x * m
		ny = @y * m
		return new Vector(nx, ny)
	div: (m) ->
		return this.mult(1 / m)
	mag: () ->
		return Math.sqrt(@x*@x + @y*@y)
	roundMag: () ->
		nx = Math.round(@x)
		ny = Math.round(@y)
		return Math.round(Math.sqrt(nx*nx + ny*ny))
	heading: () ->
		return Math.atan2(@y,@x)
	setMag: (m) ->
		return this.normalize().mult(m)
	limit: (l) ->
		if(this.mag() < l) 
			return this.clone()
		else 	
			return this.setMag(l)
	normalize: () ->
		m = this.mag()
		if(m != 0)
			nx = @x/m
			ny = @y/m
			return new Vector(nx, ny)
		else 
			return this.clone()
	toString: () ->
		return "x: " + @x + ", y: " + @y
		
this.Vector = Vector