extends Area2D

@onready var game_manager = get_node("/root/GameManager") 



func _on_body_entered(body: Node2D) -> void:
	print("boundary 3 3-4 you have entered ")

	game_manager.change_level()
	
