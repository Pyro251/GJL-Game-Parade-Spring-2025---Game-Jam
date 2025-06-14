extends Node2D

@onready var blackness_1: Node2D = $Blackness1
@onready var blackness_2: Node2D = $Blackness2
@onready var blackness_0: Node2D = $Blackness0

func _ready() -> void:
	pass
	#blackness_0.hide()
	#blackness_1.show()
	#blackness_2.visible = true

func _on_level_0_area_entered(area: Area2D) -> void:
	blackness_0.visible = false

func _on_level_1_area_entered(area: Area2D) -> void:
	blackness_1.visible = false

func _on_level_2_area_entered(area: Area2D) -> void:
	blackness_2.visible = false
