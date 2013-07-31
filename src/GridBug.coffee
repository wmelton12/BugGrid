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
    orientTowardGoal: ()->
        angle = Math.atan( (@gy - @y) / (@gx - @x) )
        if angle < 0 then angle = 360 + angle
        if angle < 45 || angle >= 315
            @dir = @plane.EAST
        else if 45 <= angle < 135
            @dir = @plane.NORTH
        else if 135 <= angle < 225
            @dir = @plane.WEST
        else if 225 <= angle < 315
            @dir = @plane.SOUTH
    dist: (x1,y1,x2,y2)->
        return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2))
    faceAwayFromWall: ()->
    moveStraight: ()->
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
       if !@goalIsReached()
               if !@wallFollowing
                   if @frontIsClear()
                          @orientTowardGoal()
                       @moveStraight()
                       return
                   else
                          alert("Start wallFollow")
                       @wallFollowing=true
                       @firstLap = true
                       @ensureWallToLeft()
                       @shortestPoint = {x:@x,y:@y}
                       @encounteredObj = {x:@x,y:@y}
                       return
               else
                   if !@firstLap
                       @wallFollow()
                       if @atPoint(@encounteredObj.x,@encounteredObj.y)
                           @firstLap = false
                       else if(@manhattanDistance(@x,@y,@gx,@gy) < @manhattanDistance(@shortestPoint.x,@shortestPoint.y, @gx,@gy))
                           @shortestPoint = {x:@x,y:@y}
                        return
                   else
                       if !@atPoint(@shortestPoint.x, @shortestPoint.y)
                           wallFollow()
                       else
                           @orientTowardGoal()
                           @wallFollowing = false
                        return true
    goalIsReached: ()->
        if @x == @gx && @y == @gy
            return true
        else 
            return false         
    goToGoal: ()->
        while !@goalIsReached()
            @orientTowardGoal()
            @moveStraight()      
    moveUntilHitWall: ()->
        until !@frontIsClear()
            #console.log("position: " +     [@x,@y] + " dir: " + @dir)
               @moveStraight()    
    wallFollow: ()->
        if !@leftIsClear() && @frontIsClear()
            @moveStraight()
        else if !@leftIsCelar() && !@frontIsClear()
            @turnRight()
            @moveStraight()
        else if @leftIsClear()
            @turnLeft()
            @moveStraight()
    atPoint: (px,py)->
        return px == @x && py==@y

this.GridBug = GridBug