extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var ticks = 0
var console = Global.console
onready var spawn_array = $SpawnPoints.get_children()
export var fire_rate = 30

func _process(delta):
	if (active):
		ticks += 1
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			if !(get_tree().paused):
				if (ticks % fire_rate == 0):
					for i in range(0, spawn_array.size()):
						fire(spawn_array[i].position, Vector2.DOWN)
			
func _pressed():
	print("this is the star!")
	._pressed()

func fire(pos, heading):
	var proj = proj_scene.instance()
	proj.init(pos, heading)
	console.get_parent().get_node("Node2D").add_child(proj)
