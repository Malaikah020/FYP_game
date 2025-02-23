extends Area2D
@onready var game_manager = get_node("/root/GameManager")  # Reference to GameManager node

func _on_body_entered(body):
	game_manager.reset_all()
	game_manager.next_level()
