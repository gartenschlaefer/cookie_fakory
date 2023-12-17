extends Area2D

# signal new content
signal new_content

var has_ingredients = []


# --
# private methods

func _ready():
	has_ingredients = []
	
	
func _add_ingredient(ingredient):
	
	# add ingredient
	has_ingredients.append(ingredient)
	print(has_ingredients)
	

func _on_body_entered(body):

	# get children
	for child in body.get_children():

		# check if ingredient
		if not child is Ingredient: continue

		# already used
		if child.get_used_flag(): return

		# add ingredients
		self._add_ingredient(child.get_type())

		# mark as used
		child.use_ingredient()

		print("ingredients in pot: ", has_ingredients)


# --
# public methods

func clean_pot():
	has_ingredients.clear()


func get_ingredient_counts_in_pot():

	# run through each ingredient
	for i in has_ingredients:

		print(i)
