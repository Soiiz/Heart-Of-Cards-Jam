extends Area2D


# Declare member variables here. Examples:
var velocity = Vector2(0, 0)
var speed = 750
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# pos (Vector2): Initial spawn position of the projectile.
# heading (Vector2): Vector representing the direction the projectile will fly. Should be normalized.
func init(pos, heading):
	position = pos
	velocity = heading * speed
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta


func _on_projectile_area_entered(area):
	if area.is_in_group("player"):
		area.take_damage(1)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
