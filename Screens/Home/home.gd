extends Node


func _on_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/Game/game.tscn")
