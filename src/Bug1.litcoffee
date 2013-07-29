# Implementation of the Bug 1 algorithm
## Task find a path between the Robot and a goal, going around obstacles
* The Robot moves toward the goal until it reaches the obstacle
* The Robot then circumnavigates the obstacle and finds the point on the obstacle     
* The Robot then goes to that point and resumes traveling toward the goal.

The Code extends the class Bug

    class Bug1 extends Bug
        constructor: (@x,@y,@gx,@gy) ->
            super @x,@y #Pass the values along to the constructor
            @wallFollowing = false
            @firstLap = true
            @heading = 0
            @shortestPoint = {}
            @encounteredObj = []      
        turnLeft: ()->
            @heading+=1
        turnRight: ()->
            #alert("turn right called")
            @heading-=1        
         
        moveStraight: ()->
             @x += 0.5 * Math.cos(@heading)
             @y += 0.5 * Math.sin(@heading)
        
        wallFollow: ()->
            @orientTowardsWallFollow()
            @x += 0.5 * Math.cos(@heading)
            @y += 0.5 * Math.sin(@heading)
            
        orientTowardsWallFollow: ()->
            while(!@frontIsClear() || @rightIsClear() || !@backIsClear() || @insideObs())
                if @numCollisions >=3
                    @x -= 0.5 * Math.cos(@heading)
                    @y -= 0.5 * Math.sin(@heading)
                else if !@frontIsClear() then @turnLeft()
                else if @rightIsClear()  then @turnRight()
                else if !@backIsClear() then @turnRight()
        frontIsClear: ()->
              refPoints = @getRefPoints(@x,@y,@heading)
              if @plane != null
                  return !@plane.checkCollision(refPoints.front...)
              else
                  return false
        rightIsClear: ()->
              refPoints = @getRefPoints(@x,@y,@heading)
              if @plane != null
                  return !@plane.checkCollision(refPoints.right...)
              else
                  return false
        backIsClear: ()->
              refPoints = @getRefPoints(@x,@y,@heading)
              if @plane != null
                  return !@plane.checkCollision(refPoints.back...)
              else
                  return false
        leftIsClear: ()->
              refPoints = @getRefPoints(@x,@y,@heading)
              if @plane != null
                  return !@plane.checkCollision(refPoints.left...)
              else
                  return false
        insideObs: ()->
            return 
        orientTowardsGoal: ()->
              @heading = @radiansToDegrees(Math.atan((@gy - @y) / (@gx - @x)))
        atPoint: (px,py) ->
              return @dist(@x,@y,px,py) < 0.05
              
        atGoal: ()->
              return @atPoint(@gx,@gy)
              
        dist: (x1,y1,x2,y2) ->
                  return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2))
        move: () ->         
             if(!@wallFollowing)
                 if(@frontIsClear())
                     @orientTowardsGoal()
                     @moveStraight()
                 else
                     @x += 3 * Math.cos(@heading)
                     @y += 3 * Math.sin(@heading)
                     @wallFollowing = true
                     while(!@frontIsClear() || @rightIsClear() || !@backIsClear() || @insideObs())
                        if @insideObs()
                            @x -= 0.5 * Math.cos(@heading)
                            @y -= 0.5 * Math.sin(@heading)
                        else if !@frontIsClear() then @turnLeft()
                        else if @rightIsClear()  then @turnLeft()
                        else if !@backIsClear() then @turnRight()
                     shortestPoint = { x:@x,y:@y }
                     @encounteredObj = [@x,@y]
             else
                 if(@firstLap)
                     if(@atPoint(@encounteredObj...))
                         @firstLap = false
                         if(@atPoint(@shortestPoint...))
                             @wallFollowing=false
                             @firstLap = true
                             @orientTowardsGoal()
                 else
                     @wallFollow()
                     if @dist(@x,@y, @gx,@gy) < @dist(@shortestPoint.x, @shortestPoint.y, @gx,@gy)
                         @shortestPoint = { x:@x, y:@y }
                     if(@atPoint(@shortestPoint...))
                         @wallFollowing=false
                         @firstLap = true
                         @orientTowardsGoal()
             @plane.drawPoint(@x,@y)
    this.Bug1 = Bug1
