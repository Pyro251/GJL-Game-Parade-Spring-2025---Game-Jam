extends Control


func _on_texture_button_pressed() -> void:
	Global.player_health = Global.max_player_health
	get_tree().change_scene_to_file("res://Scenes/World/world.tscn")
