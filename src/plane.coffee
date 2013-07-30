class Plane
  '''
  Create the planar grid upon which our bug moves.
    
  '''
  EAST: 0
  NORTH: 90
  WEST: 180
  SOUTH: 270

  constructor: (@svg, @sizeX, @sizeY, @width, @height)->
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
    @rects[x][y].style("fill", "black") if @svg?

  canMove: (x, y, dir) ->
    '''
    Can we move from (x,y) coordinates in direction `dir`?

    `dir` arg should be one of 0, 90, 180, or 270 (E, N, W, or S)
    
    '''
    if dir == @EAST
       nx = x+1
       ny = y
    else if dir == @NORTH
       nx = x
       ny = y-1
    else if dir == @WEST
       nx = x-1
       ny = y
    else if dir == @SOUTH
       nx = x
       ny = y+1
    not @grid[ny][nx]

  drawPoint: (x, y) ->
    '''Draw the point at (x,y) coordinates.'''
    @rects[y][x].style("fill","green") if @svg?

  clearPoint: (x, y) ->
    '''Clear the point at (x,y) coordinates.'''
    @rects[y][x].style('fill', 'white') if @svg?

this.Plane = Plane
