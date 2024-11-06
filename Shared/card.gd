"""
CARD
	Responsibilities:
	- Keep track of where it is and where it can go
	- Provide all of its data
	- Provide how a given card can interact with others
"""

extends Node

const Keywords = preload("res://Shared/keywords.gd")
const Sources  = preload("res://Shared/sources.gd" )

""" ATTRIBUTES """
var _cost        = 0
var _power       = 0
var _health      = 0
var _playerID    = 0
var _description = "Default description text."
var _keywords = Keywords.Keywords.EMPTY
var _source   = Sources.Sources.NONE
var _effect   # Effect
var _art      # Generated in _ready()

var dragging = false      # Draggin section
var offset = Vector2.ZERO

""" METHODS """
##########################
# GETTERS AND SETTERS
##########################
func get_cost():
	return _cost
func get_power():
	return _power
func get_health():
	return _health
func get_keywords():
	return _keywords

func set_cost(new_cost):
	_cost = new_cost
func set_power(new_power):
	_power = new_power
func set_health(new_health):
	_health = new_health
func set_keywords(new_keywords):
	_keywords = new_keywords

# Called when the node enters the scene tree for the first time.
# TODO - QUESTION: Would this act as a constructor?
func _ready() -> void:
	# Generate the art
	#_art = $Art
	#var _art_load = load("res://Assets/filler.jpg").get_data()
	#_art.create_from_image(_art_load)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
# TODO - QUESTION: Use this for drawing effects?
func _process(delta: float) -> void:
	pass

# Checks living condition
func is_dead():
	if _health > 0:
		return false
	else:
		_health = 0
		return true

# Dragging a card
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var global_mouse_position = get_global_mouse_position()
				if (global_mouse_position  - global_position).length <= texture.get_size().length() / 2:
					dragging = true
					offset = global_position - global_mouse_position
				else:
					dragging = false
	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() + offset

# The card hits something
func strike():
	pass

# Activate the card's effect
func effect():
	pass
