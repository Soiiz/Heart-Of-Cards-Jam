extends "res://cards/Card.gd"

var player = console.get_player()

func activate():
	.activate()
	player.smaller(true)
	
func deactivate():
	player.smaller(false)
	emit_signal("card_decayed", "c_empress")
	.deactivate()

func _pressed():
	print("this is the empress!")
	._pressed()
