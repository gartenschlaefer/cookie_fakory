extends Node2D

# export var for rigid ghosts
@export var rigid_saw_dust_flour_prefab: PackedScene


func _on_control_button_down():
		
	# instantiate
	var rigid_saw_dust_flour = rigid_saw_dust_flour_prefab.instantiate()
	
	# set position
	rigid_saw_dust_flour.position = self.position
	
	# scaling
	var new_scale = self.scale + Vector2(1, 1)
	
	for child in rigid_saw_dust_flour.get_children():
		
		# hack if it is ingredient (no scale)
		if child is Ingredient: continue
		child.scale = new_scale
	
	# add it to the scene
	add_sibling(rigid_saw_dust_flour)
