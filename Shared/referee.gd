"""
REFEREE
	Responsible for the rules of the CCG.
"""

extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Setup players
func init_game() -> void:
	pass

# Ensure all necessary checks are made so the game is in a valid state
# for the next player to take their turn.
func on_turn_committed() -> void:
	# Check card states
	# Check card positions
	# Check for card effects
	# Subtract any spent resource, if any
	# Set player active status
	pass

func on_turn_pass() -> void:
	# Add passed flag for round determination elsewhere
	# 
	pass

func on_round_start() -> void:
	# Draw a card
	# Increase resource amount
	# Set player active status (who starts the round)
	pass

func on_round_end() -> void:
	pass

# The player doesn't have enough resources to do something
func too_expensive() -> void:
	pass

# Validates that an attempted action was done by the active player
func current_player_turn() ->  void:
	pass

# Reports if a player's health dropped to 0 or less
func has_died() -> bool:
	return false
