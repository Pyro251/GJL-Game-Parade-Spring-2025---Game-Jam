extends Control




func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/World/world.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/options.tscn")


func _on_quit_pressed() -> void:
	pass # Replace with function body.
