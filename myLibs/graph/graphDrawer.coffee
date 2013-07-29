
a = 0
v = new Vector(Math.sin(a), Math.cos(a))
v = v.setMag(20)
w = 650
h = 300

svg = d3.select('body')
			.append('svg')
			.attr('width', w)
			.attr('height',h)

g = new Grapher(svg)

g.drawAXPlusB(v)
its = 0 
update = () ->
	a+=0.01
	v = new Vector(Math.sin(a), Math.cos(a))
	v = v.setMag(20)
	
	g.drawAXPlusB(v)
	its++
	
id = setInterval(update,10)

