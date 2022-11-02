extends "res://cards/Card.gd"

export(PackedScene) var field
var anchor
var player = console.get_player()

# Called when the node enters the scene tree for the first time.
func activate():
	anchor = field.instance()
	player.add_child(anchor)
	.activate()

func deactivate():
	if (anchor):
		anchor.queue_free()
	.deactivate()
	
func pressed():
	print("this is the hierophant!")
	.pressed()
