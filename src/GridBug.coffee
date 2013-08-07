class GridBug
    constructor: (@plane,@x,@y,@gx,@gy)->
        @dir = @plane.EAST
        @wallFollowing = false
        @firstLap = true
        @shortestPoint = []
        @encounteredObj = []
        @plane.drawPoint(@x,@y)
        @plane.drawPointCol(@gx,@gy,"red") 
    manhattanDistance: (x1,y1,x2,y2)->
        return Math.abs((y2 - y1)) + Math.abs((x2 - x1))
    frontIsClear: ()->
        return @plane.canMove(@x,@y,@dir)
    leftIsClear: ()->
        if @dir != @plane.SOUTH
            return @plane.canMove(@x,@y,@dir + 90)
        else
            return @plane.canMove(@x,@y,@plane.EAST)
    rightIsClear: ()->
        if @dir != @plane.EAST
            return @plane.canMove(@x,@y,@dir - 90)
        else 
            return @plane.canMove(@x,@y,@plane.SOUTH)
    backIsClear: ()->
        if (@dir == @plane.EAST) || (@dir == @plane.NORTH)
            return @plane.canMove(@x,@y,@dir + 180)
        else
            return @Plane.canMove(@x,@y,@dir - 180)
    turnLeft: ()->
        if @dir == @plane.EAST
            @dir = @plane.NORTH
        else if @dir == @plane.NORTH
            @dir = @plane.WEST
        else if @dir == @plane.WEST
            @dir = @plane.SOUTH
        else if @dir == @plane.SOUTH
            @dir = @plane.EAST
    turnRight: ()->
        if @dir == @plane.EAST
            @dir = @plane.SOUTH
        else if @dir == @plane.NORTH
            @dir = @plane.EAST
        else if @dir == @plane.WEST
            @dir = @plane.NORTH
        else if @dir == @plane.SOUTH
            @dir = @plane.WEST
    ensureWallToLeft: ()->
        i = 0
        while i < 4
            if !@leftIsClear() then return true
            @turnLeft()
            i++
        return false
    radToDeg: (rad) ->
        return rad * (180 / Math.PI)
    orientTowardGoal: ()->
        yDist = @gy - @y
        xDist = @gx - @x
        if yDist < 0
            if xDist < 0
                if Math.abs(xDist) > Math.abs(yDist)
                    @dir = @plane.WEST
                else
                    @dir = @plane.NORTH
            else
                if Math.abs(xDist) >  Math.abs(yDist)
                    @dir = @plane.EASt
                else
                    @dir = @plane.NORTH
        else 
            if xDist < 0
                if Math.abs(xDist) >  Math.abs(yDist)
                    @dir = @plane.WEST
                else
                    @dir = @plane.SOUTH
            else
                if Math.abs(xDist) >  Math.abs(yDist)
                    @dir = @plane.EAST
                else
                    @dir = @plane.SOUTH
    dist: (x1,y1,x2,y2)->
        return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2))
    faceAwayFromWall: ()->
    moveStraight: ()->
        console.log "x:#{@x} y:#{@y}"
        if(!@plane.canMove(@x,@y,@dir)) then return false
        if @dir == @plane.EAST
            @x++
        else if @dir == @plane.NORTH
            @y--
        else if @dir == @plane.WEST
            @x--
        else if @dir == @plane.SOUTH
            @y++
        @plane.drawPoint(@x,@y)   
        return true
    move: ()->
       if !@atGoal()
               if !@wallFollowing
                   if @frontIsClear()
                       @orientTowardGoal()
                       @moveStraight()
                   else
                       alert("Start wallFollow")
                       @wallFollowing=true
                       @firstLap = true
                       @ensureWallToLeft()
                       @shortestPoint = {x:@x,y:@y}
                       @encounteredObj = {x:@x,y:@y}
               else
                   if !@firstLap
                       @wallFollow()
                       if @atPoint(@encounteredObj.x,@encounteredObj.y)
                           @firstLap = false
                       else if(@manhattanDistance(@x,@y,@gx,@gy) < @manhattanDistance(@shortestPoint.x,@shortestPoint.y, @gx,@gy))
                           @shortestPoint = {x:@x,y:@y}
                   else
                       if !@atPoint(@shortestPoint.x, @shortestPoint.y)
                           wallFollow()
                       else
                           @orientTowardGoal()
                           @wallFollowing = false
    atPoint: (px,py)->
        return px == @x && py == @y
    atGoal: ()->
        return @atPoint(@gx,@gy)         
    goToGoal: ()->
        while true
            while !@atGoal() && @frontIsClear()
                @orientTowardGoal()
                @moveStraight()
            if @atGoal()
                console.log 'check at goal'
                return true
            console.log 'turnRight'
            @turnRight()
            console.log 'find point'
            sp = @findShortestPoint()
            console.log sp
            while !@atPoint(sp.x,sp.y) && !@atGoal()
                console.log 'go to sp'
                @wallFollow()
            if @atGoal()
                return true
            @orientTowardGoal()
    findShortestPoint: ()->
        hw = {x:@x,y:@y}
        sp = {x:@x,y:@y}
        @wallFollow()
        if @manhattanDistance(@x,@y,@gx,@gy) < @manhattanDistance(sp.x,sp.y,@gx,@gy)
            sp = {x:@x,y:@y}
        while !@atPoint(hw.x,hw.y)
            console.log 'sp finding'
            @wallFollow()
            if @manhattanDistance(@x,@y,@gx,@gy) < @manhattanDistance(sp.x,sp.y,@gx,@gy)
                sp = {x:@x,y:@y}
        return sp
    moveUntilHitWall: ()->
        until !@frontIsClear()
            #console.log("position: " + [@x,@y] + " dir: " + @dir)
            @moveStraight()    
    wallFollow: ()->
        #console.log "x:#{@x} y:#{@y}"
        if !@leftIsClear() && @frontIsClear()
            @moveStraight()
        else if !@leftIsClear() && !@frontIsClear()
            @turnRight()
            @moveStraight()
        else if @leftIsClear()
            @turnLeft()
            @moveStraight()
        
    
this.GridBug = GridBug