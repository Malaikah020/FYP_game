extends Control

@onready var score_label: Label = $ScoreLabel
@onready var level_label: Label = $LevelLabel

func update_score(new_score: int):
	score_label.text = "Score: " + str(new_score)

func update_level(new_level: int):
	level_label.text = "Level: " + str(new_level)
