# Notes
#   @points must be a list of points, not in string form!!!!!!!!!!!!
class Obstacle
  constructor: (@points,@draw) ->
    #@poly = @draw.polygon(@points).fill('black').stroke({ width: 1 }).attr('id',"#{ @points[0][0] } + #{ @points[0][1] }").attr("transform","translate(0,0)")
    @edges = []
    i = 1
    while i < @points.length
      @edges[@edges.length] = new Line(@points[i - 1][0], @points[i-1][1], @points[i][0], @points[i][1], @draw)
      i++
    @edges[@edges.length] = new Line(@points[@points.length - 1][0], @points[@points.length - 1][1],@points[0][0], @points[0][1], @draw)
    #@bb = document.getElementById(@poly.attr('id')).getBBox()
    #@draw.rect(@bb.width, @bb.height).move(@bb.x,@bb.y).style({ fill:"none", stroke:"green", "stroke-width":"1px" })
  intersectsPoint: (x,y) -> 
    #if !(@bb.y < y < @bb.y + @bb.height && @bb.x < x < @bb.x + @bb.width) then return false
    j = 0
    count = 0
    l = new Line(0,y,1000,y,@draw,false)
    while(j < @edges.length)
      if l.passesThroughLine(@edges[j]) 
        p = l.intersection(@edges[j])
        if(p[0] <= x)
            count++
      j++
    return count % 2 == 1
this.Obstacle = Obstacle





