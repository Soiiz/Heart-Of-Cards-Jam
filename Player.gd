extends KinematicBody2D

export (float) var speed = 200.0
var health = 3

func _physics_process(delta: float) -> void:
	var movement_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	
	move_and_slide(movement_direction * speed)
