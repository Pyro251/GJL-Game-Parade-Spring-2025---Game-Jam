extends CharacterBody2D

@onready var hat_sprite: Sprite2D = $GameJamWizardHatSprite
@onready var health_bar: ProgressBar = $Camera2D/HealthBar
@onready var coins_label: Label = $Camera2D/Coins
@onready var shop_ui: Node2D = $Camera2D/ShopUI

@export var speed = 400

var coins = 0
var rng = RandomNumberGenerator.new()

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
	
	coins_label.text = str(coins)
	
	if Global.hide_shop == true:
		shop_ui.hide()
	if Global.hide_shop == false:
		shop_ui.show()
	
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


func _on_coin_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Coin"):
		coins += 1
		print("you have ", coins, " coins")


func _on_debug_check_timeout() -> void:
	if Global.hide_shop == true:
		print("shop hid")
	if Global.hide_shop == false:
		print("shop shown")

func pick_shop_items():
	var pick_health_card
