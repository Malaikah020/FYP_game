extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body):
	
	GameManager.add_score(1)
	animation_player.play("pickup")
	queue_free()  # Destroy coin
	
