"""
PLAYER
Responsible for controlling card movement.
"""

extends Node2D
class_name Player

# References to the child nodes representing each pile
@onready var deck  = $Deck
@onready var hand  = $Hand
@onready var bench = $Bench
@onready var benchEco  = $BenchEco
@onready var ground    = $Ground
@onready var groundEco = $GroundEco

var selected_card = null  # Store the currently selected card
var original_pile = null  # Store the original pile the card came from
var is_dragging   = false # Track if the player is currently dragging a card
var turn_active   = true 

func _ready():
	pass
	
func _input(event):
	if turn_active:  # Only respond to input if it's this player's turn
		if event is InputEventMouseButton:
			if event.pressed:
				on_mouse_down(event)
			else:
				on_mouse_up()
		elif event is InputEventMouseMotion and is_dragging and selected_card:
			# Update card position while dragging
			on_mouse_drag(event)
 
func activate():
	turn_active = true

func deactivate():
	turn_active = false

func init_player():
	for child in get_children():
		if is_instance_of(child, Pile):
			child.init_pile()

func on_mouse_down(event):
	# Check if we're pressing on a card to start dragging
	var mouse_position = get_global_mouse_position()
	var pile = _get_pile_at_position(mouse_position)
	if pile:
		selected_card = pile.get_card_at_position(mouse_position)
		if selected_card:
			original_pile = pile
			is_dragging   = true  # Set dragging flag to true
			selected_card.start_dragging()  # Optional: change appearance for dragging
			print("Started dragging card:", selected_card.name, "from pile:", pile.name)
 
func on_mouse_drag(event):
	# Update the selected card's position to follow the mouse
	if selected_card:
		selected_card.global_position = get_global_mouse_position()
 
func on_mouse_up():
	# Check if we are releasing a dragged card
	if selected_card:
		var mouse_position = get_global_mouse_position()
		var target_pile = _get_pile_at_position(mouse_position)
		if target_pile and target_pile != original_pile:
			# Card placement
			if target_pile.can_accept_card(selected_card):
				original_pile.remove_card(selected_card)
				target_pile.add_card_to_pile(selected_card)
				selected_card.set_pile(target_pile.name)
				
				# Audio
				var card_audio_placed = AudioStreamPlayer.new()
				add_child(card_audio_placed)
				card_audio_placed.stream = load("res://Shared/Audio/Effects/card_placed.mp3")
				card_audio_placed.volume_db = -20 # -80 to 0, 0 being full volume
				card_audio_placed.play()
				
				# Console
				print("Dropped card:", selected_card.name, "onto pile:", target_pile.name)
			else:
				# Move back to original pile
				original_pile.arrange_cards()
				print("Target pile cannot accept this card")
		else:
			# Move back to original pile
			original_pile.arrange_cards()
			print("No valid target pile or same pile selected")
		
		# Reset dragging state and selection after moving
		#selected_card.stop_dragging()  # Optional: reset appearance
		selected_card = null
		original_pile = null
		is_dragging   = false
 
# TODO: Resolve pile recognition so that players can cross onto other's territory
func _get_pile_at_position(position: Vector2) -> Node:
	# Iterate over each pile and check if the card overlaps it
	for pile in [deck, hand, bench, benchEco, ground, groundEco]:
		if pile.get_global_rect().has_point(position):
			return pile
	return null
