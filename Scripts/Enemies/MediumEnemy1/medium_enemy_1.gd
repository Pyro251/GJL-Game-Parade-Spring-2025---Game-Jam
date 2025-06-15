extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const MOVE_SPEED = 2.0

var player_pos
var target_pos
var player_in_area = false

func _ready() -> void:
	animated_sprite_2d.play("flying")

func _physics_process(delta: float) -> void:
	player_pos = Global.player.position
	target_pos = (player_pos - position)
	if player_in_area == true:
		look_at(player_pos)
		position += target_pos * MOVE_SPEED * delta
	
	move_and_slide()

func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_area = true

func _on_player_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_area = false
