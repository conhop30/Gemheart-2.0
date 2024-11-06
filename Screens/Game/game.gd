extends Node

@onready var deck_load = load("res://Shared/deck.tscn")
@onready var deck = deck_load.instantiate()
@onready var card_load = load("res://Shared/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO: This should load in a deck, not create one
	add_child(deck)
	var start_position = Vector2(64, 563)
	var offset = Vector2(30, 0)
	
	# Populate cards for South Player
	for cards in range(0, 60, 1):
		var card = card_load.instantiate()
		deck.add_card(card)
		card.position = start_position + offset * cards
		get_tree().root.add_child.call_deferred(card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
