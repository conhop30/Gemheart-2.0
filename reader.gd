extends Node

class_name Reader

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
