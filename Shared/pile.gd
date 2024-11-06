"""
PILE
	Responbile for managing cards.
	Specifically, accepting and rejecting cards.
"""

extends Area2D

""" CONSTANTS """
var MAX_SIZE = 6
@onready var collision_shape = $CollisionShape2D

""" ATTRIBUTES """
var pile = []
# Set allowed card types if this pile has restrictions
var allowed_card_types = []

""" METHODS """
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func pile_size() -> int:
	return pile.size()

func add_card(card: Sprite2D):
	# Add the card as a child of the pile if allowed
	if can_accept_card(card):
		add_child(card)
		card.set_pile(self.name)
		card.position = get_stack_position()
		print("Added card:", card.name, "to pile:", self.name)
	else:
		print("Pile:", self.name, "cannot accept card:", card.name)

func can_accept_card(card: Node) -> bool:
	# Check if the card can be added based on allowed types
	if allowed_card_types.empty():
		return true  # Accept any card if no restrictions
	return true

func get_stack_position() -> Vector2:
	# Calculate a new position for stacking cards
	var offset = Vector2(randf() * 5, randf() * 5)
	return Vector2(0, 0) + offset  # Adjust based on stacking style

func remove_card(card: Node2D):
	# Remove the card from this pile's children
	if card in get_children():
		remove_child(card)
		print("Removed card:", card.name, "from pile:", self.name)

func get_card_at_position(position: Vector2) -> Node:
	# Return the topmost card at the given position within the pile
	for card in $root.get_children():
		if card.global_position.distance_to(position) < card.size:
			return card
	return null

func get_global_rect() -> Rect2:
	# Calculate the global bounds of the pile using the collision shape
	var shape = collision_shape.shape
	if shape is RectangleShape2D:
		return Rect2(global_position - shape.extents, shape.extents * 2)
	return Rect2()  # Adjust as needed if using a different shape type
 
