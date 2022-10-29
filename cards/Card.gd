extends TextureButton

# This is the base class. Only edit this if you want all cards to share a certain functionality.

# Declare member variables here. Examples:
export var round_duration = 3
var round_lifetime = 0
var active = false
signal card_picked

# Called when the node enters the scene tree for the first time.
func _ready():
	var main = Global.console
	main.connect("round_ended", self, "_on_round_ended")
	main.connect("round_started", self, "_on_round_started")
	
	# set_mouse_filter(Control.MOUSE_FILTER_IGNORE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			pass

func _pressed():
	print("click!")
	activate()

func initialize(pos):
	set_position(pos)

func activate():
	if (!active):
		active = true
		disabled = true
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
		self_modulate.a = 0 # hide button
		var p = get_parent().get_parent()
		get_parent().remove_child(self)
		p.add_child(self)
		self.set_owner(p)
