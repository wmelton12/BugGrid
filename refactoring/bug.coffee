{Space} = require 'space'

class Bug

    constructor: (@space, @x, @y, @gx, @gy) ->
        @dir = @space.EAST
        @wallFollowing = false
        @firstLap = true
        @shortestPoint = []
        @encounteredObj = []
        @space.drawPoint @x, @y
        @space.drawPoint @gx, @gy, "red"
        
    position: -> [@x, @y]

    manhattanDistance: (x1,y1,x2,y2)->
        return Math.abs((y2 - y1)) + Math.abs((x2 - x1))

    frontIsClear: ->
        return @space.canMove(@x,@y,@dir)

    leftIsClear: ->
        if @dir != @space.SOUTH
            return @space.canMove(@x,@y,@dir + 90)
        else
            return @space.canMove(@x,@y,@space.EAST)

    rightIsClear: ->
        if @dir != @space.EAST
            return @space.canMove(@x,@y,@dir - 90)
        else 
            return @space.canMove(@x,@y,@space.SOUTH)

    backIsClear: ->
        if (@dir == @space.EAST) || (@dir == @space.NORTH)
            return @space.canMove(@x,@y,@dir + 180)
        else
            return @space.canMove(@x,@y,@dir - 180)

    turnLeft: ->
      switch @dir
        when @space.EAST
          @dir = @space.NORTH
        when @space.WEST
          @dir = @space.SOUTH
        when @space.NORTH
          @dir = @space.WEST
        else # must be facing SOUTH
          @dir = @space.EAST
      @dir

    turnRight: ->
        if @dir == @space.EAST
            @dir = @space.SOUTH
        else if @dir == @space.NORTH
            @dir = @space.EAST
        else if @dir == @space.WEST
            @dir = @space.NORTH
        else if @dir == @space.SOUTH
            @dir = @space.WEST
        @dir

    ensureWallToLeft: ->
        i = 0
        while i < 4
            if !@leftIsClear() then return true
            @turnLeft()
            i++
        return false

    orientTowardGoal: ->
        angle = Math.atan( (@gy - @y) / (@gx - @x) )
        if angle < 0 then angle = 360 + angle
        if angle < 45 || angle >= 315
            @dir = @space.EAST
        else if 45 <= angle < 135
            @dir = @space.NORTH
        else if 135 <= angle < 225
            @dir = @space.WEST
        else if 225 <= angle < 315
            @dir = @space.SOUTH

    dist: (x1,y1,x2,y2)->
        return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2))

    faceAwayFromWall: ->

    moveStraight: ->
        if(!@space.canMove(@x,@y,@dir)) then return false
        if @dir == @space.EAST
            @x++
        else if @dir == @space.NORTH
            @y--
        else if @dir == @space.WEST
            @x--
        else if @dir == @space.SOUTH
            @y++
        return true


    move: -> 
      return @position() if @goalIsReached()
      if not @wallFollowing
        if @frontIsClear()
          # @orientTowardGoal()
          @moveStraight()
      else
        @wallFollowing = true
        @firstLap = true
        @ensureWallToLeft()
        @shortestPoint = 
          x: @x
          y: @y
        @encounteredObj = 
          x: @x
          y: @y
      @position()

    move_: ->
      if !@goalIsReached()
               if !@wallFollowing
                   if @frontIsClear()
                      @orientTowardGoal()
                      @moveStraight()
                      return [@x, @y]
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
                        return
      @space.drawPoint(@x,@y)

    wallFollow: ->
        if !@leftIsClear() && @frontIsClear()
            @moveStraight()
        else if !@leftIsCelar() && !@frontIsClear()
            @turnRight()
            @moveStraight()
        else if @leftIsClear()
            @turnLeft()
            @moveStraight()

    atPoint: (px, py) ->
        return px == @x && py==@y

    goalIsReached: ->
        if @x == @gx && @y == @gy
            return true
        else 
            return false

exports.Bug = Bug
