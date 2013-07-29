# represents a line
#   stores x1,y1,x2,y2, m and d

class Line
  constructor:(@x1,@y1,@x2,@y2,@draw,@drawLine = true) ->
    if @drawLine then @draw.line(@x1,@y1,@x2,@y2).stroke({ width: 1, color: 'red' })
    @vertical = false
    if @x1 == @x2 then @vertical = true
    @m = null
    @d = null
    unless @vertical
        @m = (@y2 - @y1) / (@x2 - @x1)
        @d = @y1 - @m * @x1

  eval: (x) ->
      flag = null
      if @vertical
          flag = null
      else
          flag =  @m * x + @d
      return flag
  intersection: (other) ->
    if @vertical
        return other.eval(@x1)
    else if ( @m == other.m && @d == other.d)
      return true
    else if ( @m == other.m && @d != other.d)
      return false
    else 
      x = (other.d - @d) / (@m - other.m)
      y = @m * x + @d
    return [x,y]

  passesThroughLine: (other) -> 
    
    unless @vertical
        p = @intersection(other)
        if p == true then return true
        if p == false then return false
        x = p[0]
        y = p[1]
        flag = ((@x1 < x < @x2)||(@x2 < x < @y2)) && ((other.x1 < x < other.x2) || (other.x2 < x < other.x1))
    else
        p = @intersection(other)
        x = p[0]
        y = p[1]
        flag = ((@y1 < y < @y2) || (@y2 < y < @y1)) && ((other.x1 < x < other.x2) || (other.x2 < x < other.x1))
    return flag
this.Line=Line

#{ok, eq, arrayEq, log, test} = require 'testy'

#l = new Line(0,0,1,1,null,false)

#test 'should pass', -> arrayEq [l.x1,l.y1,l.x2,l.y2],[0,0,1,1]
#test 'should pass', -> eq l.m, 1
#test 'should pass', -> eq l.d, 0

#l2 = new Line(0,1,1,0,null,false)

#test 'should pass', -> arrayEq [l2.x1,l2.y1,l2.x2,l2.y2],[0,1,1,0]
#test 'should pass', -> arrayEq [l2.m,l2.d],[-1,1]

#test 'should pass', -> ok l.passesThroughLine(l2)
#test 'should pass', -> arrayEq l.intersection(l2),[0.5,0.5]

#bl = new Line(100,100,200,200, null,false)
#bl2 = new Line(0,150,400,150,null,false)

#test 'should pass', -> ok bl.passesThroughLine(bl2)
#test 'should pass', -> arrayEq bl.intersection(bl2), [150,150]    

#vl = new Line(0.5,0,0.5,1,null,false)

#test 'should pass', -> ok vl.vertical
#test 'should pass', -> eq vl.m, null
#test 'should pass', -> eq vl.d, null
#console.log(vl.intersection(l))
#test 'should pass', -> ok vl.passesThroughLine(l)
#test.status()
