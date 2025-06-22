extends CharacterBody2D

@export var speed = 100
@export var gravity = 1800

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	horizontal_movement()
	move_and_slide()

func horizontal_movement():
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if $".".position.x < 10:
		velocity.x = 0
		$".".position.x = 10
	else:
		velocity.x = horizontal_input * speed
