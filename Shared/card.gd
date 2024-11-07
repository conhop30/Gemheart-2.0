"""
CARD
	Responsibilities:
	- Keep track of where it is and where it can go
	- Provide all of its data
	- Provide how a given card can interact with others
"""

extends Sprite2D
class_name Card

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
var _pile = "Bench"
var _piles = ["Bench",]

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
func set_pile(new_pile):
	_pile = new_pile

# Called when the node enters the scene tree for the first time.
# TODO - QUESTION: Would this act as a constructor?
func _ready() -> void:
	init_card()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# TODO - QUESTION: Use this for drawing effects?
func _process(delta: float) -> void:
	pass

func init_card():
	pass

func possible_piles():
	return _piles

# Checks living condition
func is_dead():
	if _health > 0:
		return false
	else:
		_health = 0
		return true

# Activate the card's effect
func effect():
	pass
	
func start_dragging():
	if _pile == "Bench":
		_piles = ["Ramp"]		
	elif _pile == "Ramp":
		_piles = ["Bench"]
