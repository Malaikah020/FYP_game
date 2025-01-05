extends Area2D

func _on_body_exited(body: Node2D):
	queue_free()
	print("+1 coin")
	
	
