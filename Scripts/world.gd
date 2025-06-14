extends Node2D

@onready var blackness_1: Node2D = $Blackness1
@onready var blackness_2: Node2D = $Blackness2
@onready var blackness_0: Node2D = $Blackness0

func _ready() -> void:
	$Blackness0.hide()
	$Blackness1.show()
	blackness_2.show()

func _on_level_0_area_entered(area: Area2D) -> void:
	pass
	#blackness_0.visible = false

func _on_level_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		blackness_1.hide()

func _on_level_2_area_entered(area: Area2D) -> void:
	pass
	#blackness_2.visible = false
