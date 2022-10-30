extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var fire_ticks = 0
var ticks = 0
var console = Global.console
onready var spawn_array = console.get_upper_spawns().get_children()
export var fire_rate = 0.15

func _process(delta):
	if (active):
		fire_ticks += delta
		ticks += delta
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			if !(get_tree().paused):
				if (fire_ticks >= fire_rate):
					fire_ticks = 0
					for i in range(0, spawn_array.size()):
						fire(spawn_array[i].position, Vector2.DOWN.rotated(sin(ticks * 1.5) * PI / 4))
			
func _pressed():
	print("this is the star!")
	._pressed()

func fire(pos, heading):
	var proj = proj_scene.instance()
	proj.init(pos, heading)
	console.get_parent().get_node("Node2D").add_child(proj)
