extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var ticks = 0
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
			
func _on_TextureButton_pressed():
	print("this is the star!")
	activate()

func fire(pos, heading):
	var proj = proj_scene.instance()
	proj.init(pos, heading)
	get_parent().add_child(proj)
