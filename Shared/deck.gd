"""
DECK
	Container for cards with interactive elements.
"""

extends Node2D

@onready var card_load = load("res://Shared/card.tscn")

""" ATTRIBUTES """
var deck = []

""" METHODS """
##########################
# GETTERS AND SETTERS
##########################
func get_deck():
	return deck

func generate_deck():
	for cards in range(0, 60, 1):
		var card = card_load.instantiate()
		get_tree().root.add_child.call_deferred(card)
		# TESTING: DELETE ME
		print("We added card #" + str(card))

func add_card(card):
	deck.append(card)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load in all cards to the deck
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
