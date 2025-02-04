extends Node

var score = 0
var level = 1
var target_points = 20

@onready var score_label_1: Label = $score_label1
@onready var score_label_2: Label = $score_label2
@onready var score_label_3: Label = $score_label3
@onready var label_11: Label = $"../Labels/Label11"

func add_point():
	score += 1
	print(score)
	score_label_1.text = str(score)+"/"+str(target_points)+" coins"
	score_label_2.text = str(score)+"/"+str(target_points)+" coins"
	score_label_3.text = str(score)+"/"+str(target_points)+" coins"

func add_level():
	level += 1
	print(level)
	


func _on_level_boundary_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
