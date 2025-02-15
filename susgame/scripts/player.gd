extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_paused = false  # Track if movement is paused

func _physics_process(delta: float) -> void:
	#if is_paused:
		#velocity = Vector2.ZERO  # Stop movement while paused
		#animated_sprite_2d.play("idle")  # Set animation to idle
		#return

	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get movement direction (-1, 0, 1)
	var direction := Input.get_axis("move_left", "move_right")

	# Flip the sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Pause movement when fact is displayed
#func pause_movement():
	#print("Player movement paused")
	#is_paused = true
#
## Resume movement after fact disappears
#func resume_movement():
	#print("Player movement resumed")
	#is_paused = false
	#velocity = SPEED 
