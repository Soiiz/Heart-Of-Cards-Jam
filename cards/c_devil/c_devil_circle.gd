extends Area2D
var console = Global.console

var source = "The Devil"
var player = console.get_player()
var inside = false
var inside_time = 0
var lifetime = 0
var lifetime_max = 10
export var grow_speed = 4.0
export var damage_time = 1

func _ready():
	scale = Vector2(0,0)

func _process(delta):
	scale = scale.linear_interpolate( Vector2(1, 1), grow_speed * delta )
	lifetime += delta
	if lifetime >= lifetime_max:
		queue_free()
	if (inside == true):
		inside_time += delta
	else:
		inside_time = 0
	if inside_time >= damage_time:
		player.take_damage(1, source)
		inside_time = 0

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		inside = true
		
func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		inside = false

func init(pos):
	position = pos
