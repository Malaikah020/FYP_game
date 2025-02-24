extends  Area2D

@onready var game_manager = get_node("/root/GameManager") 
 # Reference to GameManager
	

func _on_body_entered(body):
	print("Player entered boundary, advancing to next level")
	game_manager.reset_all()
	game_manager.next_level()

func _exit_tree():
	print("LevelBoundary2 was deleted!")
