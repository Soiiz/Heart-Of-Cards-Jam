extends Area2D

var orbit = 300
export var proj_speed = 2.0
var invert = false
var slow = false
export var slow_fac = 0.7
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(pos):
	orbit = pos
	position = Vector2(orbit, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (invert):
		position = position.linear_interpolate(Vector2(-orbit, 0), (proj_speed * delta if !slow else proj_speed * delta * slow_fac))
	else:
		position = position.linear_interpolate(Vector2(orbit, 0), (proj_speed * delta if !slow else proj_speed * delta * slow_fac))

func invert(on):
	invert = on

func _on_Area2D_body_entered(body):
	if body.is_in_group("player") && invert:
		body.take_damage(1)
