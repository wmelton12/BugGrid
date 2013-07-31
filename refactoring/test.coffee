{test, ok, eq, arrayEq} = require 'testy'
print = console.log 


headTests = ->
  '''
  Set of tests for the various methods in our `Heading` class.

  '''
  {Heading} = require 'space'

  head = new Heading

  test 'constants', ->
    [N, S, E, W] = [head.NORTH, head.SOUTH, head.EAST, head.WEST]
    arrayEq [E, N, W, S],
            [0, 90, 180, 270]

  test 'default direction should be EAST', ->
    ok head.dir is 'EAST'
    ok head.deg is 0

  test 'heading toward given direction', ->
    ok 'WEST' is head.toward 'WEST'
    ok head.dir is 'WEST'
    ok 'NORTH' is head.toward 'NORTH'
    ok head.dir is 'NORTH'

  test 'degree to direction conversion', ->
    ok 'EAST' is head.degToDir 0
    ok 'EAST' is head.degToDir 360
    ok 'WEST' is head.degToDir 180
    ok 'NORTH' is head.degToDir 90
    ok 'SOUTH' is head.degToDir 270

  test 'turning right', ->
    head.toward 'EAST'
    ok head.right() is 'SOUTH'
    ok head.deg is 270
    ok head.right() is 'WEST'
    ok head.deg is 180
    ok head.right() is 'NORTH'
    ok head.deg is 90
    ok head.right() is 'EAST'
    ok head.deg is 0

  test 'turning left', ->
    head.toward 'EAST'
    ok head.left() is 'NORTH'
    ok head.deg is 90
    ok head.left() is 'WEST'
    ok head.deg is 180
    ok head.left() is 'SOUTH'
    ok head.deg is 270
    ok head.left() is 'EAST'
    ok head.deg is 0

  test 'flipping in opposite direction', ->
    head.toward 'EAST'
    ok head.flip() is 'WEST'
    ok head.dir is 'WEST'
    ok head.deg is 180
    ok head.flip() is 'EAST'
    head.toward 'NORTH'
    ok head.flip() is 'SOUTH'


spaceTests = ->
  '''
  Set of tests for the various methods in our `Space` class.

  '''
  {Space, Heading} = require 'space'

  head = new Heading
  [N, S, E, W] = [head.NORTH, head.SOUTH, head.EAST, head.WEST]

  space = new Space null, 100, 100, 8, 8
  space.addWall 5, 5
  space.addWall 5, 6

  test 'should be able to move east to (4,4)', -> 
    ok space.canMove 4, 4, E

  test 'should not be able to move east to (4,5)', -> 
    ok not space.canMove 4, 5, E


bugTests = ->
  '''
  Set of tests for the various methods in our `Bug` class.

  '''
  {Space, Heading} = require 'space'
  {Bug} = require 'bug'
  
  head = new Heading
  [N, S, E, W] = [head.NORTH, head.SOUTH, head.EAST, head.WEST]

  space = new Space null, 100, 100, 8, 8
  space.addWall 5, 5
  space.addWall 5, 6
  
  bug = new Bug space, 0, 0, 10, 10
  
  test "MH distance should be 4", -> 
    dist = bug.manhattanDistance(0,0,2,2)
    ok dist is 4
    
  test "bug now facing EAST", -> ok bug.dir is E
    
  test "bug can move straight", -> ok bug.moveStraight()
    
  test "bug should be at (1,0)", -> 
    arrayEq bug.position(), [1,0]
  
  test "turn left to face NORTH", -> 
    ok bug.turnLeft() is N
    ok bug.dir is N
  
  test "turn right to face EAST again", -> 
    ok bug.turnRight() is E
    ok bug.dir is E

  test "move bug forward to (2,0)", -> 
    p = bug.move()
    arrayEq p, [2,0]

  test "turn right to face SOUTH", -> 
    ok bug.turnRight() is S

  test "move bug forward to (2,1)", -> 
    p = bug.move()
    arrayEq p, [2,1]


headTests()
spaceTests()
bugTests()

test.status()
