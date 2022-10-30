extends "res://cards/Card.gd"

var player = console.get_player()
var spawn_point
export var radius = 150
export var last_time = 10

func _process(delta):
	pass


func _pressed():
	print("this is the devil!")
	._pressed()
