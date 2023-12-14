extends Node2D

#var bg_colors = Gradient.new([Color(165,156,148), Color(138,141,143), Color(165,156,148)])
var line_color = Color(83,86,91)
var line_thickness = 1.0
var line_points = []
var line_preview = Vector2()
var line_points_array = []
var curr_drawing = 0
var selected_line
var wall_half_thickness = 5 #connections between drawings should only use half
var render_cookie_cutter = false

func _init():
	# Initialize the line points array with an empty list.
	line_points_array.append(line_points)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Draw a preview of the line in a different color.
		if line_points_array[curr_drawing].size() > 0:
			line_preview = event.position
			queue_redraw()

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		# If the right mouse button is pressed, start a new drawing.
		line_points = []
		line_points_array.append(line_points)
		curr_drawing += 1
		queue_redraw()
			
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# If left mouse button is pressed add the current mouse position to the current drawing.
		line_points_array[curr_drawing].append(event.position)
		queue_redraw()

# Draw all the lines in the line points array.
func _draw() -> void:
	for i in range(line_points_array.size()):
		for j in range(line_points_array[i].size()):
			if j > 0:
				draw_pixel_line(line_points_array[i][j-1], line_points_array[i][j], line_color)
			else:
				draw_rect(Rect2(line_points_array[i][j].x, line_points_array[i][j].y, 1, 1), line_color)
		# Draw a line connecting the last point of the current drawing to the first point of the next drawing.
		if i < line_points_array.size()-1:
			draw_pixel_line(line_points_array[i][0], line_points_array[i][line_points_array[i].size()-1], line_color)
		elif line_preview and line_points_array[i].size() > 0:
			draw_pixel_line(line_points_array[i][line_points_array[i].size()-1], line_preview, line_color)
			line_preview = 0


# Draw a line between two points using the Bresenham algorithm.
func draw_pixel_line(point_from: Vector2, point_to: Vector2, line_color: Color) -> void:
	var x1 = int(point_from.x + 0.5)
	var y1 = int(point_from.y + 0.5)
	var x2 = int(point_to.x + 0.5)
	var y2 = int(point_to.y + 0.5)

	var dx = abs(x2 - x1)
	var dy = abs(y2 - y1)
	var sx = 1 if x1 < x2 else -1
	var sy = 1 if y1 < y2 else -1
	var err = dx - dy

	while x1 != x2 or y1 != y2:
		draw_rect(Rect2(x1, y1, 1, 1), line_color)
		var e2 = 2 * err
		if e2 > -dy:
			err -= dy
			x1 += sx
		if e2 < dx:
			err += dx
			y1 += sy
