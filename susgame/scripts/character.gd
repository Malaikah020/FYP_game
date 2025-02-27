extends Area2D

@onready var sprite: AnimatedSprite2D = $Sprite2D

func _on_body_entered(body):
	
	GameManager.show_character()
	sprite.play("joy")
