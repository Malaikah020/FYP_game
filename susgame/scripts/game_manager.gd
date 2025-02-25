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

# Facts for each level
var lv1_facts = [
	"Between 2015 and 2020, the demand for lithium-ion batteries has tripled.",
	"Lithium-ion batteries are used in a wide range of electronics such as smartphones, computers, electric vehicles, and electricity grids.",
	"The mining of lithium consumes approximately 500,000 tons of water per ton of lithium extracted.",
	"70% of the world’s lithium reserves are found in Bolivia, Chile, and Argentina. This has become known as the 'lithium triangle'.",
	"In some areas of Chile, lithium mining has depleted groundwater levels by as much as one meter per year.",
	"Cobalt mining can lead to substances such as copper, uranium, cobalt, and arsenic, poisoning local food and water supplies.",
	"Cobalt mining in the DRC has led to the habitat destruction of several local species such as chimpanzees, elephants, and the critically endangered Eastern Lowland Gorilla. "
]


var lv2_facts = [
	"The extraction, processing, and shipping of metals and minerals can have environmental impacts, including habitat destruction, water pollution, and carbon emissions.",
	"Bulk Carriers, Container ships account for 3% of the world's total global emissions.",
	"13.5% of all greenhouse gas emissions come from transport, including shipping.",
	"71% of all greenhouse gas emissions from transport are from land vehicles like trucks and railways.",
	"14.4% of all greenhouse gas emissions from transport come from air travel.",
	"Underwater noise has contributed to half of all non-indigenous species in the European seas since 1949.",
	"Marine mammals use underwater clicks, whistles, and songs to communicate with their young, search for food, find mates, and avoid dangers.",
	"Of the more than 100 species systematically reviewed worldwide, every one of them shows negative responses to underwater noise."
]


var lv3_facts = [
	"Since 2007, smartphone manufacturing has required up to 968TWh of electricity. This is about the same amount of electricity used by the nation of India in an entire year.",
	"Greenpeace Calls for Sustainable Smartphone Manufacturing. ICT Monitor Worldwide",
	"Up to 3% of the world's energy demand in 2015 came from communication technology such as smartphones and computers.",
	"Carbon emissions from the production of iPhone hardware has increased by 39% from the iPhone 3GS to the iPhone 11.",
	"In 2007, the production of information and communications technology accounted for 1.3% of global gas emissions.",
	"Studies show that the total carbon emissions of a single smartphone is estimated to 50kg CO2e.",
	"Carbon footprint of electronic devices is a growing concern in the tech industry. "
	# NEED 1 more
]

var lv4_facts = [
	# Add facts for planned obsolescence and user lifetime here
	"Planned Obsolescence refers to intentionally shortening te lifespan of a device to artificially boost demand.",
	" Companies such as Nokia and Apple, update the aesthetic of their products to make older models appear outdated and out of fashion",
	"Apple has used various planned obsolescence techniques such as irreplaceable batteries and mandatory software updates",
	" Tech companies often intentionally reserve their most recent technology for their expensive high-end models, forcing the consumer to either pay for the best model or settle for the low-end ‘affordable’ model",
	"Apple have faced legal action for intentionally slowing done older iPhone models",
	"Samsung screens are prone to many functional issues that can be triggered by software updates ",
	"Devices such as washing machines, smartphones and cameras, often have components that intentionally can’t be easily replaced or fixed",
	"Another method of planned obsolescence is updating external components, such as Apple swapping out USB-A cables for USB-C cables"

]

var lv5_facts = [
	"According to Waste Electrical and Electronic Equipment (WEEE), in 2024, Ireland only recycled 30% of 11 million small devices bought.",
	"In 2021, Ireland collected 14.67 kilos of electronic equipment per person, which is the 5th highest in Europe, above the European average of 11.",
	"To uphold recycling and repair practices, a proposal in 2020 introduced the right to repair and improve reusability, updated seller requirements to repair unless cheaper to replace, and common chargers in 2024.",
	"Proper recycling of e-waste prevents environmental pollution such as toxic substances (lead, mercury, cadmium) in water and soil and health issues for humans and wildlife.",
	"Ireland is actively promoting proper electronic waste recycling and repair practices, aiming to reduce the environmental impact of electronics."
	# NEED 3
	]

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
	level_facts[1] = lv1_facts
	level_facts[2] = lv2_facts
	level_facts[3] = lv3_facts
	level_facts[4] = lv4_facts
	level_facts[5] = lv5_facts

	# Debugging: Check if ScoreLabel exists
	if score_label == null:
		print("ScoreLabel not found! Ensure it's in the correct path.")
	else:
		print("ScoreLabel is ready!")

	update_score_ui()
	update_level_ui()

# Increase score when collecting coins
func add_score(amount: int):
	score += amount
	level_scores[current_level] = score  
	print("Score: ", score)

	update_score_ui()

	if score % 2 == 0:
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
