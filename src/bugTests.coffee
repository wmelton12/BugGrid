{test, ok, eq, arrayEq} = require 'testy'

print = console.log 
alert = console.log
{Plane} = require 'plane'
{GridBug} = require 'GridBug'
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
  bug.moveStraight()
  alert([bug.x,bug.y])
  test "should pass", -> arrayEq [2,1],[bug.x,bug.y]
moveTests = -> 
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

    bug = new GridBug(plane, 0,0,5,9)

    test 'should pass', -> eq bug.dir, plane.EAST
    test 'should pass', -> arrayEq [bug.x,bug.y],[0,0]
    test 'should pass', -> arrayEq [bug.gx,bug.gy], [5,9]

    bug.orientTowardGoal()

    test 'should pass', -> eq bug.dir, plane.SOUTH
#planeTests()  # run plane tests

orientTowardsGoalTests = ->
    plane = new Plane(null, 100,100,10,10)
    bug = new GridBug(plane, 0,0,0,9)
    
    test "should pass", -> eq bug.dir, plane.EAST
    test "should pass", -> arrayEq [bug.x,bug.y],[0,0]
    test "should pass", -> arrayEq [bug.gx,bug.gy],[0,9]
    bug.orientTowardGoal()
    test "should pass", -> eq bug.dir, plane.SOUTH
    bug = new GridBug(plane,0,0,9,0)
    bug.orientTowardGoal()
    test "should pass", -> eq bug.dir, plane.EAST
    bug = new GridBug(plane,5,5,0,1)
    test "should pass", -> eq bug.dir, plane.EAST
    test "should pass", -> arrayEq [bug.x,bug.y],[5,5]
    test "should pass", -> arrayEq [bug.gx,bug.gy],[0,1]
    bug.orientTowardGoal()
    test "should pass", -> eq bug.dir, plane.WEST
    bug.gx = 8
    bug.gy = 0
    bug.orientTowardGoal()
    test "should pass", -> eq bug.dir, plane.NORTH
wallFollowTest = ->
    plane = new Plane(null,100,100,10,10)
    i = 3
    while i < 7
        j = 3
        while j < 7
            plane.addWall(i,j)
            j++
        i++
    plane.addWall(6,7)
    bug = new GridBug(plane,5,7,9,7)
    test 'should pass', -> arrayEq [bug.x,bug.y],[5,7]
    test 'should pass', -> eq bug.dir,plane.EAST
    test 'should pass', -> eq false, bug.frontIsClear()
    bug.wallFollow()
    test 'should pass', -> eq bug.dir, plane.SOUTH
    test 'should pass', -> arrayEq [bug.x,bug.y],[5,8]
    bug.wallFollow()
    test 'should pass', -> eq bug.dir, plane.EAST
    test 'should pass', -> arrayEq [bug.x,bug.y],[6,8]
moveToGoalTest = ->
    plane = new Plane(null,100,100,10,10)
    plane.addWall(5,5)
    plane.addWall(4,4)
    plane.addWall(5,4)
    bug = new GridBug(plane,0,0,9,9)
    test "should pass", -> arrayEq [bug.x,bug.y], [0,0]
    bug.goToGoal()
    test "should pass", -> arrayEq [bug.x,bug.y], [9,9]
goToGoalTest = ->
    plane = new Plane(null, 100,100,10,10)
    plane.addWall(5,5)
    plane.addWall(4,5)
    plane.addWall(6,5)
    bug = new GridBug(plane,0,0,9,9)
    test "should pass", -> arrayEq [bug.x,bug.y],[0,0]
    test "should pass", -> eq bug.dir, plane.EAST
    bug.goToGoal()
    test 'should pass', -> arrayEq [bug.x,bug.y],[9,9]
atPointTests = ->
    plane = new Plane(null, 100,100,10,10)
    bug = new GridBug(plane,5,5,9,9)
    test 'should pass', -> ok bug.atPoint(5,5)
    bug.x = 9
    bug.y = 9
    test 'should pass', -> ok bug.atPoint(9,9)
    test 'should pass', -> ok bug.atGoal()
manhattanTests = ->
    plane = new Plane(null, 100,100,10,10)
    bug = new GridBug(plane,0,0,9,9)
    test 'should pass', -> eq bug.manhattanDistance(4,1,7,2), 4
    test 'should pass', -> eq bug.manhattanDistance(1,0,2,7), 8
goToGoalTest()
test.status()