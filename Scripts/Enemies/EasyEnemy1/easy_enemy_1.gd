extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const MOVE_SPEED = 80.0

var player_pos
var target_pos
var player_in_area = false

func _ready() -> void:
	animated_sprite_2d.play("default")

func _physics_process(delta: float) -> void:
	player_pos = Global.player.position
	target_pos = (player_pos - position).normalized()
	if player_in_area == true:
		position += target_pos * MOVE_SPEED * delta

func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_area = true

func _on_player_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_area = false
