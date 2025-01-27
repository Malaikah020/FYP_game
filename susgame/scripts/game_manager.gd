extends Node

var score = 0
var level = 0
var target_points = 10

@onready var score_label_1: Label = $score_label1
@onready var score_label_2: Label = $score_label2
@onready var score_label_3: Label = $score_label3
@onready var label_11: Label = $"../Labels/Label11"

func add_point():
	score += 1
	print(score)
	score_label_1.text = str(score)+"/10 coins"
	score_label_2.text = str(score)+"/10 coins"
	score_label_3.text = str(score)+"/10 coins"
