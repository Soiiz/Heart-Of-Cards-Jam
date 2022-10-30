extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var player = console.get_player()
var rotater
export var speed = 2
export var radius = 150

func _ready():
	._ready()
	rotater = Node2D.new()
	console.get_center().add_child(rotater)
	rotater.position = Vector2(radius, 0)

func _process(delta):
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			if !(get_tree().paused):
				rotater.rotation += speed * delta

func _pressed():
	print("this is the sun!")
	._pressed()

func fire(pos, scale, rot, startup):
	var proj = proj_scene.instance()
	proj.init(pos, scale, rot, startup)
	console.get_center().add_child(proj)
