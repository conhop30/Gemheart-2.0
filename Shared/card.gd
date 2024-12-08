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
var _playerID    = 0
var _name        = "Default name"
var _description = "Default description text."
var _keywords = Keywords.Keywords.EMPTY
var _source   = Sources.Sources.NONE
var _effect   # Effect
var _art      # Generated in _ready()
var _pile  = "Deck"
var _piles = ["Deck"]

""" METHODS """
##########################
# SETTERS
##########################
func set_cost(new_cost):
	$Cost.text = str(new_cost)
func set_power(new_power):
	$Power.text = str(new_power)
func set_health(new_health):
	$Health.text = str(new_health)
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
	if $Health.text != str(0):
		return false
	else:
		$Health.text = str(0)
		return true

# Activate the card's effect
func effect():
	pass
	
func start_dragging():
	if _pile == "Deck":
		_piles = ["Hand", "Bench"]
	elif _pile == "Hand":
		_piles = ["Bench"]
	elif _pile == "Bench":
		_piles = ["Ramp", "RampEco"]
	elif _pile == "Ramp":
		_piles = ["Bench", "Ground", "RampEco"]
	elif _pile == "RampEco":
		_piles = ["Ground", "Ramp", "Bench"]
	elif _pile == "Ground":
		_piles = ["GroundEco", "Ramp"]
