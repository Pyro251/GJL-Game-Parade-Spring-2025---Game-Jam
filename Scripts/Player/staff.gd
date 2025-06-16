extends CharacterBody2D

@onready var firing_pos: Node2D = $FiringPos

var bullet_path = preload("res://Scenes/Players/orb.tscn")
var bullet_speed : float = 1000

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		fire()

func fire():
	var bullet_instance = bullet_path.instantiate()
	bullet_instance.position = get_global_position() + Vector2(50, 0).rotated(rotation)
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation)
	get_tree().get_root().call_deferred("add_child", bullet_instance)
