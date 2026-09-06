extends CharacterBody3D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotation_degrees.y -= event.relative.x * 0.5
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.5
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80.0, 80.0
		) 
		

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	const SPEED = 5.5
	
	var input_direction_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_backward"
	)
	
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	
	var direction = transform.basis * input_direction_3D
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	move_and_slide()
