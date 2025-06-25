extends CharacterBody2D

@export var speed = 100
@export var gravity = 1800

@onready var player = $"."

var actionStrength = 0.0
var last_direction = 0
var current_direction = 0

func _init() -> void:
	print(OS.get_name())

func _ready() -> void:
	current_direction = 1

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = 0
	
	if !Global.is_on_platform:
		horizontal_movement()
	move_and_slide()
	player_animation()

func horizontal_movement():
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") + actionStrength

	velocity.x = horizontal_input * speed
		
func go_right_btn():
	actionStrength = 1.0
	
func go_left_btn():
	actionStrength = -1.0
	
func cancel_go():
	actionStrength = 0.0

func player_animation():
	if Global.is_on_platform:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("idle")
	else:
		if Input.is_action_pressed("ui_left") || actionStrength < 0:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk")
			
		if Input.is_action_pressed("ui_right") || actionStrength > 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk")
		
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")

func _process(delta: float) -> void:
	if velocity.x > 0:
		current_direction = 1
	elif velocity.x < 0:
		current_direction = -1
		
	if current_direction != last_direction:
		if current_direction == 1:
			$AnimationPlayer.play("move_right")
			$Camera2D.limit_left = 50
		elif current_direction == -1:
			$AnimationPlayer.play("move_left")
			$Camera2D.limit_left = 50
			
		last_direction = current_direction	
