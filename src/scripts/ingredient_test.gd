extends "res://scripts/ingredient.gd"

var IngredientClass = load("res://scripts/ingredient.gd")

var ing_node = IngredientClass.new()

func _ready():
	ing_node.print_type()
