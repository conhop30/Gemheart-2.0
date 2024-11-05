"""
DECK
	Container for cards with interactive elements.
"""

extends Node

var card = preload("res://Shared/card.tscn")

""" ATTRIBUTES """
var deck = []

""" METHODS """
##########################
# GETTERS AND SETTERS
##########################
func get_deck():
	return deck

func generate_deck():
	for card in range(0, 60, 1):
		deck.append(card)
	# TESTING: DELETE ME
	print("We added card #" + str(card))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load in all cards to the deck
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
