extends "res://cards/Card.gd"

var player = console.get_player()

func activate():
	.activate()
	player.accelerate(true)
	
func deactivate():
	player.accelerate(false)
	emit_signal("card_decayed", "c_chariot")
	.deactivate()


func _pressed():
	print("this is the chariot!")
	._pressed()
