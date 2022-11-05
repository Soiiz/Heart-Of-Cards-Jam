extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var fire_time = 0
var time = 0
var spawn_array = console.get_magician_spawns().get_children()
var player = console.get_player()
export var proj_speed = 750
export var fire_rate = 0.15
	
func _process(delta):
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			if !(get_tree().paused):
				fire_time += delta
				time += delta
				if (fire_time >= fire_rate):
					fire_time = 0
					for i in range(0, spawn_array.size()):
						var dir = player.position - spawn_array[i].position
						fire(spawn_array[i].position, dir.normalized(), proj_speed)

func _pressed():
	print("this is the magician!")
	._pressed()

func fire(pos, heading, speed):
	var proj = proj_scene.instance()
	proj.init(pos, heading, speed)
	proj.source = "The Magician"
	console.get_center().add_child(proj)
