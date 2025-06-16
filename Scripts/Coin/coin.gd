extends CharacterBody2D

func _ready() -> void:
	$AnimatedSprite2D.play("spin")

func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		queue_free()
