extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const FALL_LIMIT = 500  # Y-position where the player is considered dead
const GameManager = preload("res://scripts/game_manager.gd")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta  # Apply gravity

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# ☠️ Check if the player has fallen off the map
	if position.y > FALL_LIMIT:
		_on_death()

func _on_death():
	print("Player has died! Restarting level...")
	GameManager.restart_level()
