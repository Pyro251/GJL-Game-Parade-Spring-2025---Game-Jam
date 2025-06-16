extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const MOVE_SPEED = 2.0

var player_pos
var target_pos
var player_in_area = false
var health = 9
var particles_path = preload("res://Scenes/Particles/enemy_death_particles.tscn")
var coin_path = preload("res://Scenes/Coin/coin.tscn")

func _ready() -> void:
	animated_sprite_2d.play("default")

func _physics_process(delta: float) -> void:
	player_pos = Global.player.position
	target_pos = (player_pos - position)
	if player_in_area == true:
		look_at(player_pos)
		position += target_pos * MOVE_SPEED * delta
	
	if health <= 0:
		die()
	
	move_and_slide()

func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_area = true

func _on_player_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_area = false

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Orb"):
		health -= Global.orb_damage

func die():
	queue_free()
	emit_particles()
	spawn_coin()

func emit_particles():
	var particles = particles_path.instantiate()
	particles.position = global_position
	get_tree().get_root().call_deferred("add_child", particles)

func spawn_coin():
	var coin = coin_path.instantiate()
	coin.position = global_position
	get_tree().get_root().call_deferred("add_child", coin)
