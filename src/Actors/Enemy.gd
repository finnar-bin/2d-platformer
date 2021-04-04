extends "res://src/Actors/Actor.gd"

func _ready() -> void:
	# Deactive enemy at the start of the game
	set_physics_process(false)
	
	_velocity.x = -speed.x 

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	if is_on_wall():
		_velocity.x *= -1.0
	
	# Only set Y so that enemy is able to change direction on collision to wall
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
