extends "res://cards/Card.gd"

var player = console.get_player()


func activate():
	.activate()
	player.gain_hp(1)
	

func _pressed():
	print("this is the high priestess!")
	._pressed()
