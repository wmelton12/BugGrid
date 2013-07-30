{test, ok, eq, arrayEq} = require 'testy'
print = console.log 


planeTests = ->

  {Plane} = require 'plane'

  plane = new Plane null, 100, 100, 8, 8
  N = plane.NORTH
  S = plane.SOUTH
  E = plane.EAST
  W = plane.WEST

  arrayEq [E, N, W, S],
          [0, 90, 180, 270]

  plane.addWall 5, 5
  plane.addWall 5, 6

  test 'should be able to move east to (4,4)', -> 
    ok plane.canMove 4, 4, E

  test 'should not be able to move east to (4,5)', -> 
    ok not plane.canMove 4, 5, E
    eq false, plane.canMove 4, 6, E


planeTests()  # run plane tests
test.status()
