extends Node2D

var count_clicks = 0
var label_count = null

# randomizer
var rng = RandomNumberGenerator.new()

# spawn path
var spawn_path = null

# export var for rigid ghosts
@export var rigid_ghost_prefab: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# setting the label count
	label_count = $canvas/click_labels/label_count
	label_count.text = str(count_clicks)
	spawn_path = $cookie_spawner


func _on_cookie_input_event(_viewport, event, _shape_idx):
	
	# detect mouse click
	if event is InputEventMouseButton:
		
		# cases to leave
		if not event.pressed: return
		if event.is_echo(): return
		if not event.button_index == 1: return
		
		# add counts
		count_clicks += 1
		
		# add label
		label_count.text = str(count_clicks)
		
		# spawn
		self._spawn_a_physics_ghost()


func _spawn_a_physics_ghost():
	
	# create instance
	var rigid_ghost = rigid_ghost_prefab.instantiate()
	
	# determine position
	var spawn_pos = spawn_path.curve.sample_baked(rng.randf() * spawn_path.curve.get_baked_length())
	
	# set position
	rigid_ghost.position = spawn_pos
	
	# add it to the scene
	add_child(rigid_ghost)
