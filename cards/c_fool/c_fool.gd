extends "res://cards/Card.gd"

var player = console.get_player()

func activate():
	.activate()
	player.slow(true)
	
func deactivate():
	player.slow(false)
	emit_signal("card_decayed", "c_fool")
	.deactivate()


func _pressed():
	print("this is the fool!")
	._pressed()
