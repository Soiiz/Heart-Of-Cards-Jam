extends KinematicBody2D

# Movement Variables
export var speed = 200
var dash_speed = 0
export var max_dash_speed = 600
export var acceleration = 2000
var dash = false;
var destination = Vector2()
var dash_movement = Vector2()

export var health = 3

onready var dash_cooldown = $DashCoolDown

func _unhandled_input(event):
	if event.is_action_pressed("Click"):
		dash = true;
		destination = get_global_mouse_position()
		print("pressed")
	
func _physics_process(delta: float) -> void:
	var movement_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
		
	move_and_slide(movement_direction * speed)
	dash(delta)

func dash(delta):
	if dash == false:
		dash_speed = 0
	else:
		dash_speed += acceleration * delta
		if dash_speed > max_dash_speed:
			dash_speed = max_dash_speed
	dash_movement = position.direction_to(destination) * dash_speed
	if position.distance_to(destination) > 5:
		dash_movement = move_and_slide(dash_movement)
	else:
		dash = false
		
func take_damage(damage):
	health -= damage
	if health <= 0:
		print("game over!")
