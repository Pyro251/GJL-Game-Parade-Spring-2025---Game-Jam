extends Control

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func _on_resolution_options_item_selected(index: int) -> void:
	match index:
		0:
			get_window().set_size(Vector2(1280, 720))
		1:
			get_window().set_size(Vector2(1920, 1080))
		2:
			get_window().set_size(Vector2(2560, 1440))
		3:
			get_window().set_size(Vector2(3840, 2160))
