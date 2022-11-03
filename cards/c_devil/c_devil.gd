extends "res://cards/Card.gd"

var player = console.get_player()
export var last_time = 10
export(PackedScene) var circle_scene
var circle_time = 0
onready var spawn_array = console.get_devil_spawn().get_children()
var used_array = []

func _process(delta):
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			if !(get_tree().paused):
				circle_time += delta
				if circle_time >= last_time:
					used_array = []
					circle_time = 0
					for i in range(0,2):
						var next_spawn = randi() % spawn_array.size()
						while (used_array.has(next_spawn)):
							next_spawn = randi() % spawn_array.size()
						var spawn_point = spawn_array[next_spawn]
						spawn_circle(spawn_point.position)
						used_array.append(next_spawn)

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
		
func deactivate():
	emit_signal("card_decayed", "c_devil")
	.deactivate()
