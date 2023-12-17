extends RigidBody2D

@export var follow_mouse = true
var mouse_pos = Vector2(0, 0)
var mouse_vel = Vector2(0, 0)

const scale_throw_impulse = Vector2(1.1, 1.1)
const clamp_throw_impulse = Vector2(1000, 1000)


func _input(event):
		
	# cases to leave
	if not follow_mouse: return
	if not event is InputEventMouse: return
	
	# mouse motion event
	if event is InputEventMouseMotion:
		
		# update mouse state
		mouse_pos = event.position
		mouse_vel = event.velocity
		return
		
	# mouse click event
	if event is InputEventMouseButton:
		
		# cases to leave
		if not event.button_index == MOUSE_BUTTON_LEFT: return
		if event.pressed: return
		if event.is_echo(): return
		
		# set variables
		follow_mouse = false
		self.freeze = false
		
		# add force to rigid body
		var throw_impulse = scale_throw_impulse * mouse_vel
		throw_impulse = throw_impulse.clamp(-clamp_throw_impulse, clamp_throw_impulse)
		
		# apply impulse
		self.apply_impulse(throw_impulse)


func _ready():
	
	# set init mouse pos
	mouse_pos = get_viewport().get_mouse_position()
	
	
func _process(_delta):
	
	# cases to leave
	if not follow_mouse: return
	
	# update position
	self.position = mouse_pos


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
