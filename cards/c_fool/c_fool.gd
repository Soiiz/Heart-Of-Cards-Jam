extends "res://cards/Card.gd"

var player = console.get_player()
signal slow_player

# Called when the node enters the scene tree for the first time.
func activate():
	.activate()
	player.slow(true)
	
func deactivate():
	player.slow(false)
	.deactivate()


func _pressed():
	print("this is the fool!")
	._pressed()
