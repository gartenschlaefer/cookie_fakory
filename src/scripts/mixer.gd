extends Node2D

func _on_mixer_area_mouse_exited():
	$mixer_area/sprite.visible = true

func _on_mixer_area_mouse_entered():
	$mixer_area/sprite.visible = false
