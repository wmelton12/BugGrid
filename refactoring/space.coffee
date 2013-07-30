class Heading
  '''
  Maintain our current direction and provide various methods
  for changing direction.

  '''
  EAST: 0
  NORTH: 90
  WEST: 180
  SOUTH: 270

  constructor: (@dir='EAST') ->
    @deg = @[@dir]

  toward: (dir) ->
    @deg = @[dir]
    @dir = dir

  flip: -> 
    @deg = (@deg + 180) % 360
    @dir = @degToDir @deg

  right: -> 
    @deg = (360 + @deg - 90) % 360
    @dir = @degToDir @deg

  left: -> 
    @deg = (@deg + 90) % 360
    @dir = @degToDir @deg

  degToDir: (deg) -> 
    deg = deg % 360
    switch deg
      when @EAST then 'EAST'
      when @WEST then 'WEST'
      when @NORTH then 'NORTH'
      when @SOUTH then 'SOUTH'
      else '?'


class Space
  '''
  Create the planar grid upon which our bug moves.
    
  '''
  EAST: 0
  NORTH: 90
  WEST: 180
  SOUTH: 270

  constructor: (@svg, @sizeX, @sizeY, @width, @height) ->
    @grid = ((0 for j in [1 .. @height]) for i in [1 .. @width])
  
    X = @sizeX / @width
    Y = @sizeY / @height

    attrs = 
      fill: 'white'
      stroke: 'black'
      'stroke-width': 0.5
  
    if @svg?
      @rects = for i in [1 .. @width]
                for j in [1 .. @height] 
                  @svg.rect(X, Y)
                      .move(j * X, i * Y)
                      .attr(attrs)

  addWall: (x, y) ->
    @grid[y][x] = 1
    @rects[x][y].style('fill', 'black') if @svg?

  canMove: (x, y, dir) ->
    '''
    Can we move from (x,y) coordinates in direction `dir`?

    `dir` arg should be one of 0, 90, 180, or 270 (E, N, W, or S)
    
    '''
    [nx, ny] = [x, y]
    if dir is @EAST
       nx = x+1
    else if dir is @NORTH
       ny = y-1
    else if dir is @WEST
       nx = x-1
    else if dir is @SOUTH
       ny = y+1
    not @grid[ny][nx]

  drawPoint: (x, y, color='green') ->
    '''Draw the point at (x,y) coordinates.'''
    @rects[y][x].style("fill", color) if @svg?

  clearPoint: (x, y) ->
    '''Clear the point at (x,y) coordinates.'''
    @rects[y][x].style('fill', 'white') if @svg?


exports.Heading = Heading
exports.Space = Space
