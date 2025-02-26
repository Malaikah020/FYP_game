extends Node2D

@onready var ray_castup: RayCast2D = $RayCastUp
@onready var ray_castdown: RayCast2D = $RayCastDown
@onready var ray_castleft: RayCast2D = $RayCastLeft
@onready var ray_castright: RayCast2D = $RayCastRight
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 60

var direction = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_castup.is_colliding():
		direction = direction*-1
		sprite_2d.flip_v = true
		rotation = randi_range(0,360)
		
	if ray_castdown.is_colliding():
		direction = direction*-1
		sprite_2d.flip_v = false
		rotation = randi_range(0,360)
		
	if ray_castleft.is_colliding():
		direction = direction*-1
		sprite_2d.flip_v = true
		rotation = randi_range(0,360)
		
	if ray_castright.is_colliding():
		direction = direction*-1
		sprite_2d.flip_v = false
		rotation = randi_range(0,360)
		
	position.y += direction * SPEED * delta
