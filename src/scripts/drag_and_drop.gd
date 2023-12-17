extends Node2D

var label_saw_dust_flour_count = null

func _ready():
  label_saw_dust_flour_count = $canvas/pot_content/label_saw_dust_flour_count
  label_saw_dust_flour_count = 0


func update_pot_content():

  # todo:
  # write saw dust flour count
  label_saw_dust_flour_count = 0
