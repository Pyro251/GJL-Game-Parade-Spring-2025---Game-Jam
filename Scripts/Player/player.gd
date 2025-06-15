extends CharacterBody2D

@onready var hat_sprite: Sprite2D = $GameJamWizardHatSprite
@onready var health_bar: ProgressBar = $HealthBar

@export var speed = 400

func _ready() -> void:
	Global.player = $"."

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	hat_sprite.look_at(get_global_mouse_position())

func _physics_process(delta):
	
	get_input()
	
	health_bar.max_value = Global.max_player_health
	health_bar.value = Global.player_health
	
	move_and_slide()
	


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Easy Enemy 1"):
		Global.player_health -= 2
	if area.is_in_group("Easy Enemy 2"):
		Global.player_health -= 2
	if area.is_in_group("Medium Enemy 1"):
		Global.player_health -= 3
	if area.is_in_group("Medium Enemy 2"):
		Global.player_health -= 4
	if area.is_in_group("Hard Enemy 1"):
		Global.player_health -= 6
	if area.is_in_group("Hard Enemy 2"):
		Global.player_health -= 8
