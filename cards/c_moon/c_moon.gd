extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var player = console.get_player()
var rotate = false
var h_spawn_array = console.get_upper_spawns().get_children()
var v_spawn_array = console.get_left_spawns().get_children()
export var radius = 150
export var fire_rate = 3
var fire_time = 0

func _process(delta):
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		elif !(get_tree().paused):
				fire_time += delta
				if (fire_time >= fire_rate):
					fire_time = 0
					if (!rotate):
						for i in range(0, h_spawn_array.size()):
							fire(h_spawn_array[i].position, Vector2(4, 96), 0, (i + 1) * .5)
						rotate = !rotate
					else:
						for i in range(0, v_spawn_array.size()):
							fire(v_spawn_array[i].position, Vector2(4, 150), PI / 2, (i + 1) * .5)
						rotate = !rotate

func _pressed():
	print("this is the moon!")
	._pressed()

func fire(pos, scale, rot, startup):
	var proj = proj_scene.instance()
	proj.init(pos, scale, rot, startup)
	proj.source = "The Moon"
	console.get_center().add_child(proj)
