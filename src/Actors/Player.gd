 extends Actor

func _physics_process(delta: float) -> void:
	# Determine if Jump key has been released early
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction := get_direction()
	_velocity = calculate_move_velocity(_velocity, speed, direction, is_jump_interrupted)
	# Get remaining _velocity on collision
	# Set up direction to determine where the floor is for is_on_floor()
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		speed: Vector2,
		direction: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	
	# Stop jump when key is released early
	if is_jump_interrupted:
		new_velocity.y = 0.0

	return new_velocity
