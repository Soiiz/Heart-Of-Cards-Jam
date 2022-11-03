extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var fire_time = 0
var time = 0
var spawn_array = console.get_upper_spawns().get_children()
export var fire_rate = 0.15
export var proj_speed = 750

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
						fire(spawn_array[i].position, Vector2.DOWN.rotated(sin(time * 1.5) * PI / 4), proj_speed)
			
func _pressed():
	print("this is the star!")
	._pressed()

func fire(pos, heading, speed):
	var proj = proj_scene.instance()
	proj.init(pos, heading, speed)
	console.get_center().add_child(proj)

func deactivate():
	emit_signal("card_decayed", "c_star")
	.deactivate()
