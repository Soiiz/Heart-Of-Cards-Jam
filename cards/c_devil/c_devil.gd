extends "res://cards/Card.gd"

var player = console.get_player()
export var last_time = 10
export(PackedScene) var circle_scene
var circle_time = 0
onready var spawn_array = console.get_devil_spawn().get_children()

func _process(delta):
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			if !(get_tree().paused):
				circle_time += delta
				if circle_time >= last_time:
					circle_time = 0
					for i in range(0,2):
						var spawn_point = spawn_array[(randi() % spawn_array.size())]
						spawn_circle(spawn_point.position)

func spawn_circle(pos):
	var circle = circle_scene.instance()
	circle.init(pos)
	console.get_center().add_child(circle)

func _pressed():
	print("this is the devil!")
	._pressed()

func activate():
	.activate()
	for i in range(0,2):
		var spawn_point = spawn_array[(randi() % spawn_array.size())]
		spawn_circle(spawn_point.position)
