extends Control

@onready var button_sound: AudioStreamPlayer = $Button

func _on_play_pressed() -> void:
	button_sound.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/start_of_game.tscn")

func _on_options_pressed() -> void:
	button_sound.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/options.tscn")

func _on_quit_pressed() -> void:
	button_sound.play()
	get_tree().quit()

func _on_credits_pressed() -> void:
	button_sound.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/credits_for_main_menu.tscn")
