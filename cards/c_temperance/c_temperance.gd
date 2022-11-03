extends "res://cards/Card.gd"

func activate():
	console.dizzy(true)
	.activate()
	
func deactivate():
	console.dizzy(false)
	emit_signal("card_decayed", "c_temperance")
	.deactivate()
