extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var player = console.get_player()
var rotater
var spawn_point
export var speed = PI/2
export var radius = 150
export var fire_rate = 0.4
var fire_time = 0

func activate():
	.activate()
	rotater = Node2D.new()
	console.get_center().add_child(rotater)
	rotater.position = Vector2(0, 0)
	spawn_point = Node2D.new()
	rotater.add_child(spawn_point)
	spawn_point.position = Vector2(radius, 0)

func _process(delta):
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		elif !(get_tree().paused):
				rotater.rotation += speed * delta
				fire_time += delta
				if (fire_time >= fire_rate):
					fire_time = 0
					fire(spawn_point.global_position, Vector2(2, 96), rotater.rotation + PI/2, .5)

func _pressed():
	print("this is the sun!")
	._pressed()

func fire(pos, scale, rot, startup):
	var proj = proj_scene.instance()
	proj.init(pos, scale, rot, startup)
	console.get_center().add_child(proj)
	
func deactivate():
	if (rotater):
		rotater.queue_free()
	.deactivate()
	
