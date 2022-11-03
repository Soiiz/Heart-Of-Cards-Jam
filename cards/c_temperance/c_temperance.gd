extends "res://cards/Card.gd"

func activate():
	console.dizzy(true)
	.activate()
	
func deactivate():
	console.dizzy(false)
	.deactivate()
