extends Node

var score = 0
var fact_index = 0
var current_level = 1  
var max_levels = 3  
var target_points = 20  

@onready var mainlabel: Label = $"../Player/Label"
@onready var score_label_1: Label = $score_label1
@onready var score_label_2: Label = $score_label2
@onready var score_label_3: Label = $score_label3
@onready var label_11: Label = $"../Labels/Label11"

@onready var fact_back: Sprite2D = $"../Player/FactBack"
@onready var fact_label: RichTextLabel = $"../Player/fact_label"
@onready var fact_timer: Timer = $"../Player/Timer"

var lv1_facts = [
	"Fact: Between 2015 and 2020, the demand for lithium-ion batteries has tripled.",
	"Fact: Lithium-ion batteries are used in a wide range of electronics such as smartphones, computers, electric vehicles, and electricity grids.",
	"Fact: The mining of lithium consumes approximately 500,000 tons of water per ton of lithium extracted.",
	"Fact: 70% of the world’s lithium reserves are found in Bolivia, Chile, and Argentina. This has become known as the 'lithium triangle'.",
	"Fact: In some areas of Chile, lithium mining has depleted groundwater levels by as much as one meter per year."
]

func _ready():
	print("GameManager Loaded")
	
	if fact_label == null or fact_back == null or fact_timer == null:
		print("ERROR: Some nodes are missing!")
	
	fact_label.visible = false
	fact_back.visible = false
	fact_timer.timeout.connect(_on_timer_timeout) 

# Show the next fact
func show_next_fact():
	if fact_index >= lv1_facts.size():
		fact_index = 0  # Reset index when all facts are shown
	
	print("Displaying fact:", lv1_facts[fact_index])

	fact_label.text = lv1_facts[fact_index]
	fact_label.visible = true
	fact_back.visible = true
	
	fact_timer.start(10)  
	fact_index += 1  

# Add points when collecting coins
func add_point():
	score += 1
	print("Score:", score)

	score_label_1.text = str(score) + "/" + str(target_points) + " coins"
	score_label_2.text = score_label_1.text
	score_label_3.text = score_label_1.text
	mainlabel.text = "Points: " + str(score) + " Level: " + str(current_level)

	if score % 3 == 0:
		print("Collected 3 coins, showing fact...")
		show_next_fact()

# Increase the level when reaching the boundary
func add_level():
	if current_level < max_levels:
		current_level += 1  
		print("Level Up! Now entering Level:", current_level)
		mainlabel.text = "Points: " + str(score) + " Level: " + str(current_level)
	else:
		print("Maximum level reached!")

# Hide fact after timer ends
func _on_timer_timeout():
	print("TIMER TRIGGERED! Hiding fact...")  
	
	fact_label.visible = false
	fact_back.visible = false
