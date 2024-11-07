# EventBus.gd
# This is a Singleton (AutoLoad) script.
# Place it in your project and enable it as an AutoLoad in Godot's project settings.

extends Node

# Dictionary to hold the subscribers by channel
var _subscribers: Dictionary = {}

# Subscribe a listener (object) to a specific channel
func subscribe(channel: String, listener: Object, method_name: String) -> void:
	if not _subscribers.has(channel):
		_subscribers[channel] = []
	var method = [listener, method_name]
	if not method in _subscribers[channel]:
		_subscribers[channel].append(method)

# Unsubscribe a listener (object) from a specific channel
func unsubscribe(channel: String, listener: Object, method_name: String) -> void:
	if _subscribers.has(channel):
		var method = [listener, method_name]
		_subscribers[channel].erase(method)
		# Clean up the channel if no more listeners exist
		if _subscribers[channel].is_empty():
			_subscribers.erase(channel)

# Publish an event to all listeners on a specific channel with optional arguments
func publish(channel: String, args: Array = []) -> void:
	if _subscribers.has(channel):
		for method in _subscribers[channel]:
			var listener = method[0]
			var method_name = method[1]
			if listener != null and listener.has_method(method_name):
				listener.callv(method_name, args)

# Clear all subscriptions (useful for resetting in development or testing)
func clear() -> void:
	_subscribers.clear()
