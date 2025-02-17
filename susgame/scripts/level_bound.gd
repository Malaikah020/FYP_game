extends Area2D

@onready var game_manager = %GameManager  

func _on_body_entered(body):
	#if body is CharacterBody2D:
	print("Player reached level boundary!")
	game_manager.add_level()
