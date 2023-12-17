@icon("res://art/ghost_16x16.png")
class_name Ingredient extends Node

@export var type := Enums.IngredientType.UNKNOWN

func print_type():
	print("type: ", type)
