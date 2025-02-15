extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D):
	print("Coin collected by:", body.name)  # Debugging
	game_manager.add_point()  # Adds a point when the player collects the coin
	animation_player.play("pickup")  # Play coin pickup animation
	queue_free()  # Remove the coin from the scene
