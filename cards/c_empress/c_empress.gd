extends "res://cards/Card.gd"

var player = console.get_player()

func activate():
	.activate()
	player.smaller(true)
	
func deactivate():
	player.smaller(false)
	.deactivate()

func _pressed():
	print("this is the empress!")
	._pressed()
