extends Node2D

var _click_pos: Array = []

func _input(event: InputEvent) -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return

	_click_pos.append(event.position)
	queue_redraw()

func _draw() -> void:
	for i in _click_pos.size():
		#if i > 1:
			#draw_circle(_click_pos[i],3,Color.RED)
			#draw_line(_click_pos[i],_click_pos[i-1],Color.RED,1)
		#else:
		draw_rect(Rect2(_click_pos[i].x,_click_pos[i].y,1,1),Color.RED)
			
			
	#for point in _click_pos:
		#draw_circle(point,3,Color.RED)
		#draw_rect(Rect2(point.x,point.y,1,1),Color.RED)
		#if last_point = 
		#draw_line(Rect2(point.x,point.y,1,1),Color.RED)
		#last_point = point
		'if _click_pos[i].x == 0 || _click_pos[i].y == 0:
		# draw a single straight line
			draw_line(Vector2.ZERO, _click_pos[i], Color.RED)
		elif abs(_click_pos[i].x) > abs(_click_pos[i].y):
			_draw_horizontal_segments(_click_pos[i])
		else:
			_draw_vertical_segments(_click_pos[i])'

#func draw_pixel_line() -> void
	
