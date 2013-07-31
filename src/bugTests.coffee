{test, ok, eq, arrayEq} = require 'testy'

print = console.log 
alert = console.log
{Plane} = require 'plane'
{GridBug} = require 'GridBug'

bugTests1= ->

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
  bug.moveStraight()
  alert([bug.x,bug.y])
  test "should pass", -> arrayEq [2,1],[bug.x,bug.y]
moveTest= ->
	plane = new Plane(null, 100,100,10,10)
	plane.addWall(5,5)
	bug = new GridBug(plane, 4, 5, 9, 5)

	test "should pass", -> arrayEq [bug.x,bug.y],[4,5]
	test "should pass", -> eq bug.dir, plane.EAST
	test "should pass", -> eq false, bug.frontIsClear()
	bug.turnLeft()
	test "should pass", -> eq bug.dir,plane.NORTH
	test "should pass", -> eq true, bug.frontIsClear()
	test "should pass", -> eq false, bug.rightIsClear()
	bug.turnRight()
	bug.turnRight()
	test "should pass", -> eq bug.dir,plane.SOUTH    
	test "should pass", -> ok bug.frontIsClear()
	test "should pass", -> eq false, bug.leftIsClear()

	bug = new GridBug(plane, 0,5,9,5)
	
	test "should pass", -> arrayEq [bug.x,bug.y],[0,5]
	bug.moveUntilHitWall()
	alert([bug.x,bug.y])
	test "should pass", -> arrayEq [bug.x,bug.y],[4,5]

	bug.turnLeft()
	bug.orientTowardGoal()
	test "should pass", -> eq bug.dir, plane.EAST
	
bugTests1()  # run bug dir tests tests
test.status()

console.log "test2"

moveTest() # run move tests

test.status()