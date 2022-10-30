extends "res://cards/Card.gd"

var player = console.get_player()
signal accelerate_player

# Called when the node enters the scene tree for the first time.
func activate():
	.activate()
	player.accelerate(true)
	
func deactivate():
	player.accelerate(false)
	.deactivate()


func _pressed():
	print("this is the chariot!")
	._pressed()
