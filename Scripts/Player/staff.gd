extends CharacterBody2D

@onready var firing_pos: Node2D = $FiringPos
@onready var attack_speed_timer: Timer = $AttackSpeed

var bullet_path = preload("res://Scenes/Players/orb.tscn")
var bullet_speed : float = 1000


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		if Global.can_fire_bullet == true:
			fire()
	
	attack_speed_timer.wait_time = Global.attack_speed


func fire():
	var bullet = bullet_path.instantiate()
	bullet.position = global_position
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized() * bullet_speed
	bullet.velocity = direction
	get_tree().get_root().call_deferred("add_child", bullet)
	Global.can_fire_bullet = false
	attack_speed_timer.start()


func _on_attack_speed_timeout() -> void:
	Global.can_fire_bullet = true
