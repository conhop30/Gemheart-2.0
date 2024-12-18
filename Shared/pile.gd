"""
PILE
	Responsible for managing cards.
	Specifically, accepting and rejecting cards.
"""

extends Node2D
class_name Pile

@export var isStacked = false # must be spread when true

""" CONSTANTS """
var MAX_SIZE  = 6
var PILE_SIZE = 6
var DECK_SIZE = 40

""" ATTRIBUTES """
@onready var collision_shape = $CollisionShape2D
@onready var card_scene = load("res://Shared/card.tscn")
@onready var card_back  = load("res://card_back.tscn")

""" METHODS """
func _ready() -> void:
	#print("Pile's global_position in _ready:", global_position)
	#print("Pile's global_transform.origin in _ready:", global_transform.origin)
	#print("Pile's name is", name)
	pass

func _process(delta: float) -> void:
	pass

func init_pile():
	var start_position = global_position
	
	for cards in range(0, DECK_SIZE, 1):
		var card = card_scene.instantiate()
		card.set_cost(45);
		add_card_to_pile(card)
		card.position = start_position# + offset * cards
	#var offset = Vector2(50, 0)
	pass

func pile_size() -> int:
	return self.get_child_count()

func add_card_to_pile(card: Sprite2D):
	if can_accept_card(card):
		add_child(card)
		card.set_pile(self.name)
		#print("Added card:", card.name, "to pile:", self.name)
		#print("card.position = " + str(card.position))
		# TODO: Reposition all cards in pile to proper formatting
		arrange_cards()

func arrange_cards():
	var current_pos = self.global_position
	var offset      = Vector2(50, 0)
	for child in get_children():
		if is_instance_of(child, Card):
			if isStacked:
				child.global_position = self.global_position
			else:
				# Must be spreading
				child.global_position = current_pos + offset
				current_pos = child.global_position

func can_accept_card(card: Card) -> bool:
	return card._piles.has(self.name)

func remove_card(card: Node2D):
	# Remove the card from this pile's children
	if card in get_children():
		remove_child(card)
		print("Removed card:", card.name, "from pile:", self.name)

func get_card_at_position(given_position: Vector2) -> Node:
	# Return the topmost card at the given position within the pile
	for child in get_children():
		var is_card = is_instance_of(child, Card)
		
		if is_card and child.global_position.distance_to(given_position) < 32:
			print(child.name)
			return child
	return null

func get_global_rect() -> Rect2:
	# Calculate the global bounds of the pile using the collision shape
	var shape = collision_shape.shape if collision_shape != null else null
	if shape and shape is RectangleShape2D:
		return Rect2(global_position - shape.extents, shape.extents * 2)
	return Rect2()
 
