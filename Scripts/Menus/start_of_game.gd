extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/dialogue.dialogue"))

func _physics_process(delta: float) -> void:
	if Global.starting_dialogue_done:
		get_tree().change_scene_to_file("res://Scenes/World/world.tscn")
