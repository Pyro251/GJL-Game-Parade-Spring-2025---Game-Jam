extends Node

var player
@onready var player_health = 20
@onready var max_player_health = 20
@onready var orb_damage = 0.5
@onready var attack_speed = 0.8
@onready var level = 1
@onready var hide_shop = true
@onready var can_fire_bullet = true
@onready var starting_dialogue_done = false
@onready var shop_dialogue_should_be_hid = true
@onready var ending_screen_time = false
@onready var credits_time = false
