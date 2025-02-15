extends Node

var score = 0
var fact_index = 0
var level = -1
var target_points = 20

@onready var mainlabel: Label = $"../Player/Label"
@onready var score_label_1: Label = $score_label1
@onready var score_label_2: Label = $score_label2
@onready var score_label_3: Label = $score_label3
@onready var label_11: Label = $"../Labels/Label11"

@onready var fact_back: Sprite2D = $"../Player/FactBack"
@onready var fact_label: RichTextLabel = $"../Player/fact_label"
@onready var fact_timer: Timer = $"../Player/Timer"

#@onready var player: CharacterBody2D = $"../Player"


var lv1_facts = [
	"Fact: Between 2015 and 2020, the demand for lithium-ion batteries has tripled.",
	"Fact: Lithium-ion batteries are used in a wide range of electronics such as smartphones, computers, electric vehicles, and electricity grids.",
	"Fact: The mining of lithium consumes approximately 500,000 tons of water per ton of lithium extracted.",
	"Fact: 70% of the world’s lithium reserves are found in Bolivia, Chile, and Argentina. This has become known as the 'lithium triangle'.",
	"Fact: In some areas of Chile, lithium mining has depleted groundwater levels by as much as one meter per year."
]

# Ensure labels and timer exist
func _ready():
	print("GameManager Loaded")
	print("Fact Label:", fact_label)
	print("Fact Back:", fact_back)
	print("Fact Timer:", fact_timer)
	

	if fact_label == null or fact_back == null or fact_timer == null:
		print("ERROR: Some nodes are missing!")

	# Ensure labels are initially hidden
	fact_label.visible = false
	fact_back.visible = false
	fact_timer.timeout.connect(_on_timer_timeout) 

# Show the next fact in sequence
func show_next_fact():
	if fact_index >= lv1_facts.size():
		fact_index = 0  # Reset fact index when reaching the end

	print("Displaying fact:", lv1_facts[fact_index])  # Debugging output

	fact_label.text = lv1_facts[fact_index]
	fact_label.visible = true
	fact_back.visible = true
	
	# PAUSE the game
	#Engine.time_scale = 0
	#player.pause_movement() 
	
	print("Starting timer for 10 seconds...")
	fact_timer.start(10)# Ensure the timer actually starts
	print("Timer started: ", fact_timer.time_left)  # Start timer to hide fact after 10 seconds
	fact_index += 1  # Move to next fact for next cycle

func add_point():
	score += 1
	print("Score:", score)

	# Update UI
	score_label_1.text = str(score) + "/" + str(target_points) + " coins"
	score_label_2.text = score_label_1.text
	score_label_3.text = score_label_1.text
	mainlabel.text = "Points: " + str(score) + " Level: " + str(level)

	# Show a new fact every 3 coins collected
	if score % 3 == 0:
		print("Collected 3 coins, showing fact...")
		show_next_fact()

func add_level():
	level += 1
	print("Level:", level)
	mainlabel.text = "Points: " + str(score) + " Level: " + str(level)

func _on_timer_timeout():
	print("TIMER TRIGGERED! Resuming game...")  # Debugging
	
	fact_label.visible = false
	fact_back.visible = false
	
	#Engine.time_scale = 1
	#player.resume_movement()  # Resume only the player's movement
