extends CharacterBody2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const MOVE_SPEED = 80.0

var player_in_area = false
var health = 5
var particles_path = preload("res://Scenes/Particles/enemy_death_particles.tscn")
var coin_path = preload("res://Scenes/Coin/coin.tscn")

func _ready() -> void:
	animated_sprite_2d.play("default")
	call_deferred("seeker_setup")
	

func seeker_setup():
	await get_tree().physics_frame
	if Global.player:
		nav_agent.target_position = Global.player.global_position

func _physics_process(delta: float) -> void:
	if player_in_area == true:
		if Global.player:
			nav_agent.target_position = Global.player.global_position
		if nav_agent.is_navigation_finished():
			return
		var current_agent_pos = global_position
		var next_path_position = nav_agent.get_next_path_position()
		velocity = current_agent_pos.direction_to(next_path_position) * MOVE_SPEED
		look_at(Global.player.position)
	
	if health <= 0:
		die()
	
	move_and_slide()

func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		animated_sprite_2d.play("Walk")
		player_in_area = true

func _on_player_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		animated_sprite_2d.play("Idle")
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
