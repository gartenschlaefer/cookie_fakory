extends Node2D

#var bg_colors = Gradient.new([Color(165,156,148), Color(138,141,143), Color(165,156,148)])
var line_color = Color.GRAY
var fill_color = Color.DARK_GRAY
var line_thickness = 3
var line_pixel_points = []
var line_preview = Vector2()
var cookie_cutter_designs = []
var curr_drawing = 0
var selected_line
var render_cookie_cutter = true
var render_height = 15
var nearest_pixel
var last_stored_pixel

func _init():
	# Initialize the line points array with an empty list.
	cookie_cutter_designs.append(line_pixel_points)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Draw a preview of the line in a different color.
		if cookie_cutter_designs[curr_drawing].size() > 0:
			line_preview = event.position
			queue_redraw()

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		# If the right mouse button is pressed, start a new drawing.
		if cookie_cutter_designs[curr_drawing].size() > 2:
			cookie_cutter_designs[curr_drawing].append(cookie_cutter_designs[curr_drawing][0])
			line_pixel_points = []
			cookie_cutter_designs.append(line_pixel_points)
			curr_drawing += 1
			queue_redraw()
			
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# If left mouse button is pressed add the current mouse position to the current drawing.
		nearest_pixel = Vector2(int(event.position.x + 0.5),int(event.position.y + 0.5))
		if last_stored_pixel != nearest_pixel:
			last_stored_pixel = nearest_pixel
			cookie_cutter_designs[curr_drawing].append(nearest_pixel)
			queue_redraw()

# Draw all the lines in the line points array.
func _draw() -> void:
	if render_cookie_cutter:
		for i in range(cookie_cutter_designs.size()):
			for j in range(cookie_cutter_designs[i].size()):
				for k in range(render_height):
					draw_pixel_line(cookie_cutter_designs[i][j],cookie_cutter_designs[i][j] , line_color,1 , fill_color,k)
					if j > 0:
						draw_pixel_line(cookie_cutter_designs[i][j-1],cookie_cutter_designs[i][j] , line_color,1 , fill_color,k)
	for i in range(cookie_cutter_designs.size()):
		for j in range(cookie_cutter_designs[i].size()):
			draw_pixel_line(cookie_cutter_designs[i][j],cookie_cutter_designs[i][j] , Color.AZURE,line_thickness , fill_color)
			#draw_rect(Rect2(cookie_cutter_designs[i][j].x, cookie_cutter_designs[i][j].y, 3, 3), line_color)
			if j > 0:
				draw_pixel_line(cookie_cutter_designs[i][j-1], cookie_cutter_designs[i][j], Color.AZURE,line_thickness , fill_color)
	if line_preview and cookie_cutter_designs[curr_drawing].size() > 0:
			draw_pixel_line(cookie_cutter_designs[curr_drawing][cookie_cutter_designs[curr_drawing].size()-1], line_preview, line_color,line_thickness,fill_color)
			line_preview = 0

# Draw a line between two points using the Bresenham algorithm.
func draw_pixel_line(point_from: Vector2, point_to: Vector2, line_color: Color, line_width: int = 1, fill_color: Color = line_color, yOffset: int = 0) -> void:
	var x1 = int(point_from.x)
	var y1 = int(point_from.y+yOffset)#int(point_from.y + 0.5)
	var x2 = int(point_to.x)#+xOffset#int(point_to.x + 0.5)
	var y2 = int(point_to.y+yOffset)#int(point_to.y + 0.5)
	if x1 > x2 and y2 > y1:
		line_color = line_color.darkened(0.15)
		fill_color = fill_color.darkened(0.15)
	elif x2> x1 and y1 > y2:
		line_color = line_color.darkened(-0.15)
		fill_color = fill_color.darkened(0.15)
	var use_color
	for i in ((line_width+1)/2):
			if i == ((line_width+1)/2)-1:
				use_color = line_color
			else:
				use_color = fill_color
			draw_circle(Vector2(x2,y2),i,use_color)

	var dx = abs(x2 - x1)
	var dy = abs(y2 - y1)
	var sx = 1 if x1 < x2 else -1
	var sy = 1 if y1 < y2 else -1
	var err = dx - dy

	while x1 != x2 or y1 != y2:
		for i in ((line_width+1)/2):
			if i == ((line_width+1)/2)-1:
				use_color = line_color
			else:
				use_color = fill_color
			if i > 0:
				if dx < dy:
					draw_rect(Rect2(x1+i*sx, y1, 1, 1), use_color)
					draw_rect(Rect2(x1-i*sx, y1, 1, 1), use_color)
				else:
					draw_rect(Rect2(x1, y1+i*sy, 1, 1), use_color)
					draw_rect(Rect2(x1, y1-i*sy, 1, 1), use_color)
			else:
				draw_rect(Rect2(x1, y1, 1, 1), use_color)
			
		var e2 = 2 * err
		if e2 > -dy:
			err -= dy
			x1 += sx
		if e2 < dx:
			err += dx
			y1 += sy
