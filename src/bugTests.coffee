{test, ok, eq, arrayEq} = require 'testy'

print = console.log 
alert = console.log

planeTests = ->

  {Plane} = require 'plane'
  {GridBug} = require 'GridBug'
  plane = new Plane null, 100, 100, 8, 8
  N = plane.NORTH
  S = plane.SOUTH
  E = plane.EAST
  W = plane.WEST

  arrayEq [E, N, W, S],
          [0, 90, 180, 270]

  plane.addWall 5, 5
  plane.addWall 5, 6
  bug = new GridBug(plane,0,0,10,10)	
  test "should pass", -> eq bug.manhattanDistance(0,0,2,2), 4
  test "should pass", -> eq bug.dir, plane.EAST
  test "should pass", -> ok bug.moveStraight()
  test "should pass", -> arrayEq [1,0], [bug.x,bug.y]
  bug.turnLeft()
  test "should pass", -> eq bug.dir, plane.NORTH
  bug.turnRight()
  test "should pass", -> eq bug.dir, plane.EAST
  bug.move()
  alert([bug.x,bug.y])	
  test "should pass", -> arrayEq [2,0],[bug.x,bug.y]
  bug.turnRight()
  test "should pass", -> eq bug.dir, plane.SOUTH
  bug.move()
  alert([bug.x,bug.y])
  test "should pass", -> arrayEq [2,1],[bug.x,bug.y]
planeTests()  # run plane tests
test.status()
