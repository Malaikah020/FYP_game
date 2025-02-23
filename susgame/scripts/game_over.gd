extends Control

func _on_restart_pressed():
	GameManager.current_level = 1
	GameManager.score = 0
	GameManager.change_scene("res://scenes/Level_1.tscn")  # Restart game
