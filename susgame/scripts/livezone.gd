extends Area2D

@onready var timer = $Timer
@onready var game_manager = get_node("/root/GameManager")  # Reference to GameManager node

func _on_body_entered(body):
	
	# Determine the correct behavior based on the level
	game_manager.reset_all()
	# For levels above 1, reset the player to the spawn point and set level score to 0
	reset_player_to_spawn("res://scenes/GameOver.tscn")

	


# Reset player to spawn point based on the level
func reset_player_to_spawn(level_scene_path: String):
	# Load the level scene (but don't instantiate it yet)
	var level_scene = load(level_scene_path)
	
	# Check if the level scene loaded correctly
	if level_scene:
		# Instantiate the level scene to access the SpawnPoint node
		var instantiated_scene = level_scene.instantiate()

		# Find the SpawnPoint node
		var spawn_point = instantiated_scene.get_node("SpawnPoint")
		
		if spawn_point:
			print(0)
			# Get the player node (ensure it's the correct path, adjust if needed)
			var player = get_node("/root/Player")  # Assuming Player is under the root node

			# Check if the player node exists
			if player:
				# Reset the player position to the spawn point
				player.global_position = spawn_point.global_position
				# Set the player's score for the new level to 0
				game_manager.level_scores[game_manager.current_level] = 0
				# Update score UI (this method should be defined in your UI script)
				game_manager.update_score_ui()
			else:
				print("Error: Player node not found!")
		else:
			print("Error: SpawnPoint node not found in scene: ", level_scene_path)
	else:
		print("Error: Could not load the level scene:", level_scene_path)
