extends Area2D

@export var speed = 1

func _physics_process(delta: float) -> void:
	if Global.is_on_platform:
		detect_input()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.is_on_platform = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		Global.is_on_platform = false

func detect_input():
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	print(self.position.y, horizontal_input)
	self.position.y = -(horizontal_input) * speed
