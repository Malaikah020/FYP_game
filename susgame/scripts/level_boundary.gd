extends Area2D

@onready var game_manager: Node = %GameManager
#
#func _on_body_exited(body: Node2D):
	#print("aaazaa")
	#game_manager.add_level()
	#animation_player.play("pickup")

#
func _on_body_entered(body: Node2D) -> void:
	print("new level")
	game_manager.add_level()
	
