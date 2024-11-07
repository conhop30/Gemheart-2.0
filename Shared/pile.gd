"""
PILE
	Responbile for managing cards.
	Specifically, accepting and rejecting cards.
"""

extends Node2D
class_name Pile

""" CONSTANTS """
var MAX_SIZE = 6
@onready var collision_shape = $CollisionShape2D
@onready var card_scene = load("res://Shared/card.tscn")

""" ATTRIBUTES """

""" METHODS """
func _ready() -> void:
	print("Pile's global_position in _ready:", global_position)
	print("Pile's global_transform.origin in _ready:", global_transform.origin)
	print("Pile's name is", name)

func _process(delta: float) -> void:
	pass

func init_pile():
	
	var start_position = global_position + Vector2(8, 8)
	var offset = Vector2(96, 0) # size of card?
	
	for cards in range(0, 10, 1):
		var card = card_scene.instantiate()
		add_card(card)
		card.position = start_position + offset * cards
		
	
func pile_size() -> int:
	return self.get_child_count()

func add_card(card: Sprite2D):
	if can_accept_card(card):
		add_child(card)
		card.set_pile(self.name)
		card.position = get_stack_position()
		print("Added card:", card.name, "to pile:", self.name)
	else:
		print("Pile:", self.name, "cannot accept card:", card.name)

func can_accept_card(card: Card) -> bool:
	return card._piles.has(self.name)
	
func get_stack_position() -> Vector2:
	# Calculate a new position for stacking cards
	var offset = Vector2(randf() * 5, randf() * 5)
	return Vector2(0, 0) + offset  # Adjust based on stacking style

func remove_card(card: Node2D):
	# Remove the card from this pile's children
	if card in get_children():
		remove_child(card)
		print("Removed card:", card.name, "from pile:", self.name)

func get_card_at_position(given_position: Vector2) -> Node:
	# Return the topmost card at the given position within the pile
	for child in get_children():
		var is_card = is_instance_of(child, Card)
		
		#var clicked_card = child.global_position.distance_to(given_position) < child.region_rect.size
		if is_card and child.global_position.distance_to(given_position) < 32:
			print(child.name)
			return child
	return null

func get_global_rect() -> Rect2:
	# Calculate the global bounds of the pile using the collision shape
	var shape = collision_shape.shape if collision_shape != null else null
	if shape and shape is RectangleShape2D:
		return Rect2(global_position - shape.extents, shape.extents * 2)
	return Rect2()  # Adjust as needed if using a different shape type
 
