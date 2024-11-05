extends Node

var deck = "res://Shared/card.gd"
var card = preload("res://Shared/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for card in range(0, 60, 1):
		deck.append(card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
