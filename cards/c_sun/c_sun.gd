extends "res://cards/Card.gd"

func _process(delta):
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			pass

func _on_TextureButton_pressed():
	print("this is the sun!")
	._on_TextureButton_pressed()
