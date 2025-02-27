extends Area2D

func _on_body_entered(body):
	
	GameManager.show_character()
	queue_free()  # Destroy coin
