extends Area2D


var has_ingredients = []


func _ready():
	has_ingredients = [Enums.IngredientType.SAW_DUST_FLOUR]
	
	
func _add_ingredient(ingredient):
	
	# add ingredient
	has_ingredients.append(ingredient)
	print(has_ingredients)
	

func _clean_pot():
	has_ingredients.clear()
