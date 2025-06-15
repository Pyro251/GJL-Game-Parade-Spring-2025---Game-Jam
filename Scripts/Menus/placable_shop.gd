extends CharacterBody2D



func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		pass
		#put script for shop here
