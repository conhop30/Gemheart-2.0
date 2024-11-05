"""
PILE
	Responbile for managing cards.
	Specifically, accepting and rejecting cards.
"""

extends Node

""" CONSTANTS """
var MAX_SIZE = 6

""" ATTRIBUTES """
var pile = []

""" METHODS """
func pile_size() -> int:
	return pile.size()

func add_card(card) -> void:
	pass
