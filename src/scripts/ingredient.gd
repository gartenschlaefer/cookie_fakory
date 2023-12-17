# --
# ingredient class

# icon
@icon("res://art/ghost_16x16.png")

# class
class_name Ingredient extends Node

# type
@export var type := Enums.IngredientType.UNKNOWN

# used flag
var is_used = false


# --
# private methods

func _ready():
	is_used = false


# --
# public methods

func print_type():
	print("type: ", type)


func get_type():
	return self.type


func get_used_flag():
	return is_used


func use_ingredient():
	is_used = true