extends Node2D

func _ready() -> void:
	Global.ending_screen_time = true
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/EndingDialogue.dialogue"))

func _physics_process(delta: float) -> void:
	if Global.credits_time:
		get_tree().change_scene_to_file("res://Scenes/Menus/credits.tscn")
