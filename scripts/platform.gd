extends Area2D

@export var speed = 1
@export var start_pos = 315
@export var limit_pos = -918.5

func _physics_process(delta: float) -> void:
	condition_on_platform()
	if Global.is_on_platform:
		detect_input()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.is_on_platform = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		Global.is_on_platform = false
		
func condition_on_platform():
	if self.position.y > start_pos:
		Global.is_on_platform = false
		self.position.y = start_pos
	elif self.position.y < limit_pos:
		Global.is_on_platform = false
		self.position.y = limit_pos

func detect_input():
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") + Global.actionStrength
	
	self.position.y += -(horizontal_input) * speed
