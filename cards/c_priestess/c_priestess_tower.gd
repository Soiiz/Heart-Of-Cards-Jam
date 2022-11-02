extends Area2D
var console = Global.console

var player = console.get_player()
var inside = false
var inside_time = 0
var lifetime = 0
var lifetime_max = 10
export var target_scale = Vector2(0.4, 0.4)
export var grow_speed = 4.0
export var heal_time = 4

func _ready():
	scale = Vector2(0,0)

func _process(delta):
	scale = scale.linear_interpolate( target_scale, grow_speed * delta )
	lifetime += delta
	if lifetime >= lifetime_max:
		queue_free()
	if (inside == true && player.health < 4):
		inside_time += delta
	else:
		inside_time = 0
	if inside_time >= heal_time:
		player.gain_hp(1)
		inside_time = 0

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		inside = true
		
func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		inside = false
