extends Node

# Global Game Variables
var score: int = 0
var current_level: int = 1
var max_levels: int = 4  # Total number of levels
var fact_index: int = 0  # To track which fact is being shown

# Level scene paths (Ensure these are correct)
var levels := [
	"res://scenes/Level_1.tscn",
	"res://scenes/Level_2.tscn",
	"res://scenes/Level_3.tscn",
	"res://scenes/Level_4.tscn"
]

# Dictionaries to store scores and facts
var level_scores = {}  
var level_facts = {}   

@onready var fact_back: Sprite2D = $"../Player/FactBack"
@onready var fact_label: RichTextLabel = $"../Player/fact_label"
@onready var fact_timer: Timer = $"../Player/Timer"  
@onready var player: CharacterBody2D = $"../Player"
@onready var score_label: Label = $"../Player/UI/ScoreLabel"
@onready var level_label: Label = $"../Player/UI/LevelLabel"

func _ready():
	print("GameManager Initialized")

	# Debugging: Check if fact_timer is valid
	if fact_timer != null:
		print("fact_timer is initialized")
		fact_timer.timeout.connect(hide_fact)  
	else:
		print("fact_timer is null!")

	hide_fact()  

	# Initialize score storage
	level_scores[current_level] = 0

	# Debugging: Check if ScoreLabel exists
	if score_label == null:
		print("ScoreLabel not found! Ensure it's in the correct path.")
	else:
		print("ScoreLabel is ready!")

	update_score_ui()

# Increase score when collecting coins
func add_score(amount: int):
	score += amount
	level_scores[current_level] = score  
	print("Score: ", score)

	update_score_ui()

	if score % 4 == 0:
		show_next_fact()

# Update score on UI
func update_score_ui():
	if score_label != null:
		score_label.text = "Score: " + str(score)
	else:
		print("Error: ScoreLabel is null!")

func update_level_ui():
	if level_label != null:
		level_label.text = "Level: " + str(current_level)
	else:
		print("Error: LevelLabel is null!")

# Show the next fact for the current level
func show_next_fact():
	var facts = level_facts.get(current_level, [])
	if facts.size() == 0:
		print("No facts available for this level.")
		return

	if fact_index >= facts.size():
		fact_index = 0  

	print("Displaying fact:", facts[fact_index])

	if fact_label != null and fact_back != null:
		fact_label.text = facts[fact_index]
		fact_label.visible = true
		fact_back.visible = true

		fact_timer.start(10)
		fact_index += 1  
	else:
		print("Error: fact_label or fact_back is null!")

# Move to the next level
func next_level():
	if current_level < max_levels:
		print("Current Level Before Increment:", current_level)
		level_scores[current_level] = score  
		current_level += 1  
		print("Level Up! Now entering Level:", current_level)
		update_level_ui()

		fact_index = 0  

		score = level_scores.get(current_level, 0)

		# Debugging
		print("Attempting to load:", levels[current_level - 1])

		change_scene(levels[current_level - 1])
	else:
		print("Game Completed!")
		change_scene("res://scenes/GameOver.tscn")  

# Handles safe scene transitions while keeping the player
func change_scene(scene_path: String):
	print("Changing scene to:", scene_path)

	if ResourceLoader.exists(scene_path):
		var new_scene = load(scene_path).instantiate()
		get_tree().current_scene.queue_free()  
		get_tree().root.add_child(new_scene)
		get_tree().current_scene = new_scene

		# Move player to the spawn position in the new scene
		var spawn_point = new_scene.get_node_or_null("SpawnPoint")  
		if spawn_point:
			player.global_position = spawn_point.global_position
			print("Player moved to new SpawnPoint.")
		else:
			print("Warning: No SpawnPoint found in new level!")
	else:
		print("Error: Scene does not exist", scene_path)

# Hide the fact when the timer runs out
func hide_fact():
	if fact_label != null and fact_back != null:
		fact_label.visible = false
		fact_back.visible = false
	else:
		print("Error: fact_label or fact_back is null!")

# Reset fact index and UI visibility
func reset_all():
	print("Resetting fact index and UI elements.")
	fact_index = 0 
	if fact_label != null:
		fact_label.visible = false
	if fact_back != null:
		fact_back.visible = false
