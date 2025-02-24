extends Area2D

@onready var game_manager = get_node("/root/GameManager") 
 # Reference to GameManager
@onready var level_bound: Area2D = $"."
	

func _on_body_entered(body):
	print("Player entered boundary, advancing to next level 2")
	game_manager.reset_all()
	level_bound.queue_free()
	game_manager.next_level()

func _exit_tree():
	print("LevelBoundary was deleted!")
	
		
