extends "res://cards/Card.gd"


export(PackedScene) var proj_scene
var player = console.get_player()
var rotater
var orb
var time = 0
export var slow_fac = 0.7
export var speed = PI/1.5
export var radius = 150
export var proj_scale = 5

# Called when the node enters the scene tree for the first time.
	
func activate():
	.activate()
	rotater = Node2D.new()
	console.get_center().add_child(rotater)
	orb = proj_scene.instance()
	rotater.add_child(orb)
	orb.init(Vector2(radius, 0), Vector2(proj_scale, proj_scale))

func _process(delta):
	if (active):
		time += delta
		if (round_lifetime >= round_duration):
			deactivate()
		elif !(get_tree().paused):
				rotater.rotation += (speed * delta if (!orb.slow) else speed * delta * slow_fac)
				orb.position = Vector2(radius + sin(time * 1.2) * radius/3, 0)

func _pressed():
	print("this is the wheel of fortune!")
	._pressed()

func deactivate():
	if (rotater):
		rotater.queue_free()
	.deactivate()
