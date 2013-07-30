class Plane
    constructor: (@svg, @sizeX, @sizeY, @width ,@height)->
        @EAST = 0
        @NORTH = 90
        @WEST = 180
        @SOUTH = 270
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
        alert("wx: " + @widthX + " wy: " + @heightY)
        @rects = []
        i = 0
        if @svg != null
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
        if !svg != null then @rects[x][y].style("fill","black")
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
        alert("nx: " + nx + " ny: " + ny)
        alert(@pts)
        return !@pts[ny][nx]
           
    drawPoint: (x,y)->
           if @svg != null then @rects[y][x].style("fill","green")
    clearPoint: (x,y)->
           if @svg != null then @rects[y][x].style("fill","white")
this.Plane = Plane