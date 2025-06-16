extends Area2D

var velocity = Vector2()

func _process(delta):
	position += velocity * delta
	
	if velocity.length() > 0:
		rotation = velocity.angle()
	


func _on_orb_life_timer_timeout() -> void:
	print("THE ORB IS DYING!!!!!!!!")
	queue_free()
	
