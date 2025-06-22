extends CharacterBody2D

@onready var hat_sprite: Sprite2D = $GameJamWizardHatSprite
@onready var health_bar: ProgressBar = $Camera2D/HealthBar
@onready var coins_label: Label = $Camera2D/Coins
@onready var shop_ui: Node2D = $Camera2D/ShopUI
@onready var attack_speed_timer: Timer = $AttackSpeed
@onready var attack_speed_bar: ProgressBar = $Camera2D/AttackSpeedBar
@onready var press_space_to_open_shop_label: Label = $Camera2D/PressSpaceToOpenShop
@onready var level_number_label: Label = $Camera2D/LevelNumber
@onready var pickup_coin_sound: AudioStreamPlayer = $PickupCoinSound
@onready var pickup_heart_sound: AudioStreamPlayer = $PickupHeartSound
@onready var hurt_sound: AudioStreamPlayer = $HurtSound
@onready var walking_sound: AudioStreamPlayer = $WalkingSound
@onready var walking_timer: Timer = $WalkingTimer

#card onready vars
@onready var common_health: TextureButton = $Camera2D/ShopUI/CommonHealth
@onready var rare_health: TextureButton = $Camera2D/ShopUI/RareHealth
@onready var extraordinary_health: TextureButton = $Camera2D/ShopUI/ExtraordinaryHealth
@onready var common_attack: TextureButton = $Camera2D/ShopUI/CommonAttack
@onready var rare_attack: TextureButton = $Camera2D/ShopUI/RareAttack
@onready var extraordinary_attack: TextureButton = $Camera2D/ShopUI/ExtraordinaryAttack
@onready var common_attack_speed: TextureButton = $Camera2D/ShopUI/CommonAttackSpeed
@onready var rare_attack_speed: TextureButton = $Camera2D/ShopUI/RareAttackSpeed
@onready var extraordinary_attack_speed: TextureButton = $Camera2D/ShopUI/ExtraordinaryAttackSpeed

@export var speed = 400

var coins = 0
var rng = RandomNumberGenerator.new()
var walking = false

func _ready() -> void:
	Global.player = $"."
	press_space_to_open_shop_label.hide()
	pick_shop_items()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	hat_sprite.look_at(get_global_mouse_position())

func _physics_process(delta):
	
	get_input()
	
	health_bar.max_value = Global.max_player_health
	health_bar.value = Global.player_health
	
	coins_label.text = str(coins)
	level_number_label.text = str(Global.level)
	
	if Global.hide_shop:
		shop_ui.hide()
	if !Global.hide_shop:
		shop_ui.show()
	
	if Input.is_action_just_pressed("shop"):
		if !Global.hide_shop:
			pick_shop_items()
			
		if Global.hide_shop:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/ShopDialogue.dialogue"))
	
	attack_speed_timer.wait_time = Global.attack_speed
	attack_speed_bar.max_value = Global.attack_speed
	attack_speed_bar.value = attack_speed_timer.time_left
	
	if Input.is_action_just_pressed("shoot"):
		if Global.can_fire_bullet == true:
			attack_speed_timer.start()
	
	if Global.player_health <= 0:
		die()
	
	if Input.is_action_pressed("down") or Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		walking = false
	else:
		walking = true
	
	if walking:
		walking_timer.start()
	
	move_and_slide()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Easy Enemy 1"):
		hurt_sound.play()
		Global.player_health -= 2
	if area.is_in_group("Easy Enemy 2"):
		hurt_sound.play()
		Global.player_health -= 2
	if area.is_in_group("Medium Enemy 1"):
		hurt_sound.play()
		Global.player_health -= 3
	if area.is_in_group("Medium Enemy 2"):
		hurt_sound.play()
		Global.player_health -= 4
	if area.is_in_group("Hard Enemy 1"):
		hurt_sound.play()
		Global.player_health -= 6
	if area.is_in_group("Hard Enemy 2"):
		hurt_sound.play()
		Global.player_health -= 8


func _on_coin_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("Coin"):
		pickup_coin_sound.play()
		coins += 1
		print("you have ", coins, " coins")


func _on_debug_check_timeout() -> void:
	if Global.hide_shop == true:
		print("shop hid")
	if Global.hide_shop == false:
		print("shop shown")

func pick_shop_items():
	var pick_health_card = rng.randi_range(1, 3)
	var pick_attack_card = rng.randi_range(1, 3)
	var pick_attack_speed_card = rng.randi_range(1, 3)
	
	#pick health card
	if pick_health_card == 1:
		common_health.show()
		rare_health.hide()
		extraordinary_health.hide()
	if pick_health_card == 2:
		common_health.hide()
		rare_health.show()
		extraordinary_health.hide()
	if pick_health_card == 3:
		common_health.hide()
		rare_health.hide()
		extraordinary_health.show()
	
	#pick attack card
	if pick_attack_card == 1:
		common_attack.show()
		rare_attack.hide()
		extraordinary_attack.hide()
	if pick_attack_card == 2:
		common_attack.hide()
		rare_attack.show()
		extraordinary_attack.hide()
	if pick_attack_card == 3:
		common_attack.hide()
		rare_attack.hide()
		extraordinary_attack.show()
	
	#pick attack speed card
	if pick_attack_speed_card == 1:
		common_attack_speed.show()
		rare_attack_speed.hide()
		extraordinary_attack_speed.hide()
	if pick_attack_speed_card == 2:
		common_attack_speed.hide()
		rare_attack_speed.show()
		extraordinary_attack_speed.hide()
	if pick_attack_speed_card == 3:
		common_attack_speed.hide()
		rare_attack_speed.hide()
		extraordinary_attack_speed.show()

func _on_common_health_pressed() -> void:
	if coins >= 4:
		Global.max_player_health += 5
		coins -= 4
		#Global.hide_shop = true

func _on_rare_health_pressed() -> void:
	if coins >= 12:
		Global.max_player_health += 8
		coins -= 12
		#Global.hide_shop = true

func _on_extraordinary_health_pressed() -> void:
	if coins >= 20:
		Global.max_player_health += 12
		coins -= 20
		#Global.hide_shop = true

func _on_common_attack_pressed() -> void:
	if coins >= 5:
		Global.orb_damage += 1
		coins -= 5
		#Global.hide_shop = true

func _on_rare_attack_pressed() -> void:
	if coins >= 10:
		Global.orb_damage += 1.5
		coins -= 10
		#Global.hide_shop = true

func _on_extraordinary_attack_pressed() -> void:
	if coins >= 18:
		Global.orb_damage += 2
		coins -= 18
		#Global.hide_shop = true

func _on_common_attack_speed_pressed() -> void:
	if coins >= 5:
		Global.attack_speed -= 0.05
		coins -= 5
		#Global.hide_shop = true

func _on_rare_attack_speed_pressed() -> void:
	if coins >= 14:
		Global.attack_speed -= 0.1
		coins -= 14
		#Global.hide_shop = true

func _on_extraordinary_attack_speed_pressed() -> void:
	if coins >= 22:
		Global.attack_speed -= 0.2
		coins -= 22
		#Global.hide_shop = true

func die():
	get_tree().change_scene_to_file("res://Scenes/Menus/death_screen.tscn")


func _on_shop_area_detect_area_entered(area: Area2D) -> void:
	press_space_to_open_shop_label.show()


func _on_shop_area_detect_area_exited(area: Area2D) -> void:
	press_space_to_open_shop_label.hide()


func _on_heart_detect_area_entered(area: Area2D) -> void:
	if Global.player_health <= Global.max_player_health - 5:
		pickup_heart_sound.play()
		Global.player_health += 5
	if Global.player_health > Global.max_player_health -5:
		pickup_heart_sound.play()
		Global.player_health = Global.max_player_health


func _on_ending_detect_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/ending_screen.tscn")


func _on_walking_timer_timeout() -> void:
	walking_sound.play()
	if walking:
		walking_timer.start()
