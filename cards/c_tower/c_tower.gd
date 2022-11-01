extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var fire_time = 0
var time = 0
var center = console.get_center()
export var fire_rate = 0.15
export var proj_count = 5
var phi = 2 * PI / proj_count

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
					for i in range(0, proj_count):
						fire(center.position, Vector2.RIGHT.rotated((phi * i) + 2 * PI * sin(time / 4)))
func _pressed():
	print("this is the tower!")
	._pressed()

func activate():
	.activate()
	

func fire(pos, heading):
	var proj = proj_scene.instance()
	proj.init(pos, heading)
	console.get_center().add_child(proj)
