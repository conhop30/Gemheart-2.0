extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	# Audio
	var button_pressed = AudioStreamPlayer.new()
	add_child(button_pressed)
	button_pressed.stream = load("res://Screens/Launch/button_click_launch.wav")
	button_pressed.volume_db = 0 # -80 to 0, 0 being full volume
	button_pressed.play()
	
	# Next screen, the home page
	get_tree().change_scene_to_file("res://Screens/Home/home.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
