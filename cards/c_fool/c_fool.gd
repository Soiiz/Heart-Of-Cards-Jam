extends "res://cards/Card.gd"

var player = console.get_player()

func activate():
	.activate()
	player.slow(true)
	
func deactivate():
	player.slow(false)
	.deactivate()


func _pressed():
	print("this is the fool!")
	._pressed()
