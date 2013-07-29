class Bug
  constructor: (@x,@y) ->
    @plane = null
  move: ()->
  
  getRefPoints: (x,y,heading)->
    console.log("Bug heading: " + heading)
    points = {}
    points.front = [x + 5 * Math.cos(@degreesToRadians(heading)), y + 5 * Math.sin(@degreesToRadians(heading))]
    rightAngle = @degreesToRadians(heading - 90)
    points.right = [x + 10 * Math.cos(@rightAngle), y + 10 * Math.sin(@rightAngle)]
    backAngle = @degreesToRadians(heading + 180)
    points.back = [x + 5 * Math.cos(backAngle), y + 5 * Math.sin(backAngle)]
    leftAngle = @degreesToRadians(heading + 90)
    points.left = [x + 10 * Math.cos(leftAngle), y + 10 * Math.sin(leftAngle)]
    return points
  putInPlane: (plane) ->
    @plane = plane
  degreesToRadians: (degs) ->
    return degs * (Math.PI / 180)
  radiansToDegrees: (rads) ->
    return rads * (180 / Math.PI)
this.Bug = Bug
