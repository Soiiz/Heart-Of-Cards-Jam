extends Control

# This is the base class. Only edit this if you want all cards to share a certain functionality.

# Declare member variables here. Examples:
export var round_duration = 3
var round_lifetime = 0
onready var button = $TextureButton
var active = false
signal card_picked

# Called when the node enters the scene tree for the first time.
func _ready():
	var main = get_node("/root/Main/Console")
	main.connect("round_ended", self, "_on_round_ended")
	main.connect("round_started", self, "_on_round_started")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			pass

func _on_TextureButton_pressed():
	activate()

func initialize(pos):
	button.set_position(pos)

func activate():
	if (!active):
		active = true
		button.disabled = true
		emit_signal("card_picked")

func deactivate():
	queue_free()
	
func _on_round_ended():
	round_lifetime += 1
	if (round_lifetime >= round_duration):
		deactivate()
		
func _on_round_started():
	if (!active):
		deactivate()
	else:
		button.self_modulate.a = 0 # hide button
