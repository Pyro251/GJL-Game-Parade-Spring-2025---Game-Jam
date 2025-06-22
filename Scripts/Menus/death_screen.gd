extends Control

@onready var button_sound: AudioStreamPlayer = $ButtonSound

func _on_texture_button_pressed() -> void:
	button_sound.play()
	Global.player_health = Global.max_player_health
	Global.level = 1
	Global.max_player_health = 20
	Global.orb_damage = 0.5
	Global.attack_speed = 0.8
	get_tree().change_scene_to_file("res://Scenes/World/world.tscn")
