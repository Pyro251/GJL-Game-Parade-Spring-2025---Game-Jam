extends CharacterBody2D

@onready var able_to_open_shop = false
var shop_open = false

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	pass

func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		able_to_open_shop = true
		print("player entered shop area")

func _physics_process(delta: float) -> void:
	if able_to_open_shop == true:
		if Input.is_action_just_pressed("shop"):
			if shop_open == false:
				shop_open = true
			if shop_open == true:
				shop_open = false
	
	if shop_open == true:
		Global.hide_shop = true
	if shop_open == false:
		Global.hide_shop = false

func _on_player_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		able_to_open_shop = false
		print("player exited shop area")
