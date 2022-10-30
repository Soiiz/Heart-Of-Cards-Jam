extends Area2D
var console = Global.console

var player = console.get_player()
var inside = false
var inside_time = 0
var lifetime = 0
var lifetime_max = 10
export var damage_time = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime += delta
	if lifetime >= lifetime_max:
		queue_free()
	if (inside == true):
		inside_time += delta
	else:
		inside_time = 0
	if inside_time >= damage_time:
		player.take_damage(1)
		inside_time = 0

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
		inside = true
		
func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		inside = false

func init(pos):
	position = pos
