class GridBug
    constructor: (@plane,@x,@y,@gx,@gy)->
        @dir = @plane.EAST
        @wallFollowing = false
        @plane.drawPoint(@x,@y)

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
        while @leftIsClear()
            @turnLeft()
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
        if @dir == @plane.EAST
            @x++
        else if @dir == @plane.NORTH
            @y--
        else if @dir == @plane.WEST
            @x--
        else if @dir == @plane.SOUTH
            @y++
    move: ()->
        if(@wallFollowing)
            if @frontIsClear() && !@leftIsClear()
                @moveStraight()
            else if !@frontIsClear() && !@leftIsClear()
                @turnLeft()
            else if  @leftIsClear()
                @turnLeft()
                @moveStraight()
        else
            @orientTowardGoal()
            if @frontIsClear
                @moveStraight()
            else
                alert("wallFollowing")
                @wallFollowing = true
                @ensureWallToLeft()
        @plane.drawPoint(@x,@y)
    goalIsReached: ()->
        if @x == @gx && @y == @gy
            return true
        else 
            return false
this.GridBug = GridBug