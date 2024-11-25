extends Pile

class_name Deck

@onready var pile = load("res://Shared/pile.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init_deck():
	var start_position = global_position
	
	for cards in range(0, DECK_SIZE, 1):
		print("INSIDE INIT_DECK()")
		var card = card_scene.instantiate()
		pile.add_card_to_pile(card)
		card.position = start_position# + offset * cards

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
