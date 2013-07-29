class Collider
    constructor: ()->
    	@x1 = 0
    	@x2 = 0
   	circleAndHorizontalLine: (c, l) ->
   		@x1 = l.attr('x1')
   		@x2 = l.attr('x2')
   		y = l.attr('y1')
   		if y != l.attr('y2')
   			alert('invalid line')
   		
   		cx = parseInt(c.attr('cx'))
   		cy = parseInt(c.attr('cy'))
   		r = parseInt(c.attr('r'))
   		top = cy - r
   		bottom = cy + r
   		#alert("bottom: " + bottom + " cy: " + cy + " r: " + r)
   		leftMargin = cx - r
   		rightMargin = cx + r
   		
   		#alert("x1:"+@x1+"x2:"+@x2)
   		if leftMargin < @x2 && rightMargin > @x1
   			if top < y < bottom
   				#alert "collision detected! This has been changed"
   				#alert("top: " + top + " bottom: " + bottom + " r: " + r + " cy: " + cy)
   				return true
   			
    distance: (ax,ay,bx,yb) ->
        return Math.sqrt(Math.pow(bx - ax, 2) + Math.pow(yb - ay, 2))
            
this.Collider = Collider