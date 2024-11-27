extends Button

func _on_pressed():
	EventBus.publish("player_passed")
