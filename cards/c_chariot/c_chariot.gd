extends "res://cards/Card.gd"

var player = console.get_player()

func activate():
	.activate()
	player.accelerate(true)
	
func deactivate():
	player.accelerate(false)
	.deactivate()


func _pressed():
	print("this is the chariot!")
	._pressed()
