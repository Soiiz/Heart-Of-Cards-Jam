extends "res://cards/c_star/c_star_proj.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(pos, _scale, speed = 0):
	position = pos
	scale = _scale
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	._physics_process(delta)
	rotation += 2.0 * delta
func _on_projectile_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
