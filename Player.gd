extends KinematicBody2D

signal health_updated

# Movement Variables
export var speed = 200
var dash_speed = 0
export var max_dash_speed = 1200
export var acceleration = 600
var dash = false;
var destination = Vector2()
var dash_movement = Vector2()
var dash_cooldown = 2
export var health = 3
var slow = false
var accelerate = false

export var dash_delay: float = 20

func _ready():
	Global.player = self
	connect("health_updated", Global.console, "_on_health_updated")
	emit_signal("health_updated", health)

func _unhandled_input(event):
	if event.is_action_pressed("Click") and dash == false and dash_cooldown >= dash_delay:
		dash = true;
		dash_speed = 400
		destination = get_global_mouse_position()

		dash_cooldown = 0.0
		print("pressed")

func _process(delta):
	dash_cooldown += delta
	

func _physics_process(delta: float) -> void:
	var movement_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
		
	if dash == false:
		if slow == true:
			move_and_slide(movement_direction * speed * 0.7)
		elif accelerate == true:
			move_and_slide(movement_direction * speed * 2)
		else:
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
	dash_movement = position.direction_to(destination) * dash_speed
	if position.distance_to(destination) > 5:
		dash_movement = move_and_slide(dash_movement)
	else:
		dash = false
		
func take_damage(damage):
	health -= damage
	emit_signal("health_updated", health)
	
	print("yeowch")
	if health <= 0:
		print("game over!")

func slow(b):
	slow = b
	
func accelerate(b):
	accelerate = b
