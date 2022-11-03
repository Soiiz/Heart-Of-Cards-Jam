extends "res://cards/Card.gd"

var player = console.get_player()

func activate():
	.activate()
	player.bigger(true)
	
func deactivate():
	player.bigger(false)
	emit_signal("card_decayed", "c_emperor")
	.deactivate()

func _pressed():
	print("this is the emperor!")
	._pressed()
