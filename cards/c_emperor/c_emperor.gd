extends "res://cards/Card.gd"

var player = console.get_player()

func activate():
	.activate()
	player.bigger(true)
	
func deactivate():
	player.bigger(false)
	.deactivate()

func _pressed():
	print("this is the emperor!")
	._pressed()
