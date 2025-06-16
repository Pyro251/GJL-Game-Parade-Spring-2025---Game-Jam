extends CharacterBody2D

@onready var firing_pos: Node2D = $FiringPos

var bullet_path = preload("res://Scenes/Players/orb.tscn")
var bullet_speed : float = 1000


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		fire()


func fire():
	var bullet = bullet_path.instantiate()
	bullet.position = global_position
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized() * bullet_speed
	bullet.velocity = direction
	get_tree().get_root().call_deferred("add_child", bullet)
