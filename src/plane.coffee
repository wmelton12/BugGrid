class Plane
    constructor: (@svg, @sizeX, @sizeY, @width ,@height)->
        @EAST = 0
        @NORTH = 90
        @WEST = 180
        @SOUTH = 270
        @firstLap = true
        @pts = []
        i = 0
        while i < @width
            j = 0
            toAdd = []
            while j < @height
                toAdd[toAdd.length] = false
                j++
            i++
            @pts[@pts.length] = toAdd
        @widthX = @sizeX / @width
        @heightY = @sizeY / @height
        #alert("wx: " + @widthX + " wy: " + @heightY)
        @rects = []
        if @svg != null
        	i = 0
        	while i < @width
            	j = 0
            	toAdd = []
            	while j < @height
                	#alert("i: " + i + " j: " + j + " color: " + color)
                	toAdd[toAdd.length] = @svg.rect(@widthX,@heightY).move(j * @widthX, i * @heightY).attr({
                	     stroke:"black",
                    	 "stroke-width":0.5,
                    	 fill: "white"
                	})   
                	j++
            	@rects[@rects.length] = toAdd
            	i++ 
    addWall: (x,y)->
        @pts[y][x] = true
        if @svg != null then @rects[y][x].style("fill","black")
    canMove: (x,y,dir) ->
        if dir == @EAST
           nx = x+1
           ny = y
        else if dir == @NORTH
           nx = x
           ny = y-1
        else if dir == @WEST
           nx = x-1
           ny = y
        else if dir == @SOUTH
           nx = x
           ny = y+1
        if ny >= @height || nx >= @width then return false
        else return !@pts[ny][nx]
           
    drawPoint: (x,y)->
           @drawPointCol(x,y,"green")
    drawPointCol: (x,y,color)->
           if @svg != null then @rects[y][x].style("fill",color)
    clearPoint: (x,y)->
           if @svg != null then @rects[y][x].style("fill","white")
this.Plane = Plane