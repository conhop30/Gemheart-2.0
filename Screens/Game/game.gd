extends Node

@onready var nDeck     = $PlayerNorth/Deck
@onready var sDeck     = $PlayerSouth/Deck
@onready var card_load = load("res://Shared/card.tscn")
@onready var action_button = $Board/ActionButton
@onready var nHealth   = $PlayerNorth/HealthNorth
@onready var sHealth   = $PlayerSouth/HealthSouth
@onready var nResource = $PlayerNorth/ResourcesNorth
@onready var sResource = $PlayerSouth/ResourcesSouth
@onready var nHand     = $PlayerNorth/Hand
@onready var sHand     = $PlayerSouth/Hand
const STARTING_HEALTH  = 20
const STARTING_RESOURCE = 5

# TODO: Turn this into a rand() modulo
var current_player: String = "PlayerNorth"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var json_as_dict
	
	# Initiate
	init_board_values()
	init_music()
	json_as_dict = read_json(json_as_dict)
	extract_json_value(json_as_dict)
	
	# Start the first player's turn
	for child in get_children():
		if is_instance_of(child, Player):
			child.init_player()
			# TODO: move this turn initiation code somewhere that makes more sense
			if child.name == "PlayerNorth":
				child.activate()
			else:
				child.deactivate()
	
	# more setup code for signals
	EventBus.subscribe("player_passed", self, "on_turn_passed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func read_json(json_as_dict):
	var file = "res://Cards/all_cards.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	json_as_dict = JSON.parse_string(json_as_text)
	return json_as_dict

func extract_json_value(json_as_dict):
	if "all_cards" in json_as_dict:
		# Access the card by its key, e.g., "card_two"
		var target_key = "card_two"
		if target_key in json_as_dict["all_cards"]:
			var card = json_as_dict["all_cards"][target_key]
			var cost = card.get("cost", "Cost not found")
			print("The cost of ", target_key, " is: ", cost)
		else:
				print("Card with key ", target_key, " not found.")

func populate_card():
	pass

func init_board_values() -> void:
	# Set the player health displays
	nHealth.text = str(STARTING_HEALTH)
	sHealth.text = str(STARTING_HEALTH)
	# Set the action button's text
	action_button.text = "Player North's turn"
	# Set resource values
	nResource.text = str(STARTING_RESOURCE)
	sResource.text = str(STARTING_RESOURCE)

func init_music() -> void:
	var bg_music = AudioStreamPlayer.new()
	add_child(bg_music)
	
	# Load the audio stream
	var audio_stream = load("res://Shared/Audio/Music/gemheart_default_bg_music_loopable.mp3") as AudioStream
	if audio_stream is AudioStreamMP3:  # Ensure it’s an AudioStream with a loop property
		audio_stream.loop = true
	
	bg_music.stream = audio_stream
	bg_music.volume_db = -50  # Start with a very low volume
	bg_music.play()
	
	# Fade in music
	var tween = create_tween()  # New Tween in Godot 4
	tween.tween_property(bg_music, "volume_db", -30, 0.33)  # Fade to -30 dB over 0.33 seconds
	tween.play()

# Ensure all necessary checks are made so the game is in a valid state
# for the next player to take their turn.
func on_turn_committed() -> void:
	# Check card states
	# Check card positions
	# Check for card effects
	# Subtract any spent resource, if any
	# Set player active status
	pass

func on_turn_passed() -> void:
	# Toggle the current player
	current_player = "PlayerSouth" if current_player == "PlayerNorth" else "PlayerNorth"
	
	if current_player == "PlayerNorth":
		action_button.text = "Player North's turn"
	else:
		action_button.text = "Player South's turn"

	# Activate/deactivate players based on the new current player
	for child in get_children():
		if child is Player:
			if child.name == current_player:
				child.activate()
			else:
				child.deactivate()


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
