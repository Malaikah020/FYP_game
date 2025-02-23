extends CanvasLayer  # Since it's a UI layer

@onready var fact_back: Sprite2D = $FactBack
@onready var fact_label: RichTextLabel = $fact_label
@onready var fact_timer: Timer = $Timer

func _ready():
	hide_fact()  # Hide fact initially
	fact_timer.timeout.connect(hide_fact)  # Connect timer signal

# Show a fact and start the timer
func show_fact(fact_text: String, duration: float = 10.0):
	fact_label.text = fact_text
	fact_back.visible = true
	fact_label.visible = true
	fact_timer.start(duration)

# Hide the fact when the timer runs out
func hide_fact():
	fact_back.visible = false
	fact_label.visible = false
