extends CharacterBody2D

@onready var able_to_open_shop = false
@onready var shop_open = false

func _ready() -> void:
	pass

func _on_player_detect_area_entered(area: Area2D) -> void:
	#if area.is_in_group("Player"):
	able_to_open_shop = true
	print("player entered shop area")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shop") and able_to_open_shop == true:
		print("shop button pressed")
		if shop_open == false:
			shop_open = true
			print("trying to set shop open to true")
		elif shop_open == true:
			shop_open = false
			print("trying to set shop open to false")
	
	if shop_open == true:
		Global.hide_shop = false
	if shop_open == false:
		Global.hide_shop = true

func _on_player_detect_area_exited(area: Area2D) -> void:
	#if area.is_in_group("Player"):
	able_to_open_shop = false
	print("player exited shop area")


func _on_debug_timer_timeout() -> void:
	if able_to_open_shop == true:
		print("able to open shop")
	if able_to_open_shop == false:
		print(" NOT able to open shop")
	if shop_open == true:
		print("Shop open.")
	if shop_open == false:
		print("Shop NOT open.")
	
