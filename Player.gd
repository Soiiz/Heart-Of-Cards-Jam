extends KinematicBody2D

# Movement Variables
export var speed = 200
var dash_speed = 0
export var max_dash_speed = 1200
export var acceleration = 600
var dash = false;
var destination = Vector2()
var dash_movement = Vector2()

export var health = 3

onready var dash_cooldown = $DashCoolDown
export var dash_delay: float = 5

func _unhandled_input(event):
	if event.is_action_pressed("Click") && dash_cooldown.is_stopped():
		dash = true;
		dash_speed = 400
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
		dash_speed -= acceleration * delta
		if dash_speed <= 0:
			dash_speed = 0
			dash = false
			dash_cooldown.start(dash_delay)
	dash_movement = position.direction_to(destination) * dash_speed
	if position.distance_to(destination) > 5:
		dash_movement = move_and_slide(dash_movement)
	else:
		dash = false
		
func take_damage(damage):
	health -= damage
	if health <= 0:
		print("game over!")
