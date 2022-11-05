extends TextureButton

# This is the base class. Only edit this if you want all cards to share a certain functionality.

# Declare member variables here. Examples:
export var round_duration = 3
export var float_height = -0.1
export var float_easing = .05
var console = Global.console
var round_lifetime = 0
var active = false
export(String) var card_name
signal card_picked(source)
signal card_decayed(source)

var glow_shader = preload("res://arts/shaders/glow.tres")
var wave_vfx_scene = preload("res://arts/vfx/wave_ring.tscn")
var wave_vfx
var wave_vfx_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	var main = Global.console
	main.connect("round_ended", self, "_on_round_ended")
	main.connect("round_started", self, "_on_round_started")
	
	# set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	
	# adding the wave animation in code
	wave_vfx = wave_vfx_scene.instance()
	add_child(wave_vfx)
	wave_vfx.set_emitting(true)
	wave_vfx.set_position(Vector2(230, 450))
	wave_vfx.set_z_index(12)
	
	# set selected shader
	var shadermat = ShaderMaterial.new()
	shadermat.set_shader(glow_shader)
	set_material(shadermat)
	shadermat.set_shader_param("width", 0.0)
	shadermat.set_shader_param("outline_color", Color("d2d35a"))
	shadermat.set_shader_param("pixel_size", 2)
	shadermat.set_shader_param("width_speed", 0.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_hovered() && !active):
		if wave_vfx.emitting == true:
			wave_vfx.set_emitting(false)
			get_material().set_shader_param("width", 40.0)
			get_material().set_shader_param("width_speed", 5.0)
		anchor_bottom = lerp(anchor_bottom, float_height, float_easing)
	elif !active:
		if wave_vfx.emitting == false:
			wave_vfx.set_emitting(true)
			get_material().set_shader_param("width", 0.0)
			get_material().set_shader_param("width_speed", 0.0)
		anchor_top = lerp(anchor_top, 0, float_easing)
	if (active):
		if (round_lifetime >= round_duration):
			deactivate()
		else:
			anchor_bottom = lerp(anchor_bottom, -3, 0.1)


func _pressed():
	print("click!")
	SoundPlayer.play_positional("Water3", get_position())
	activate()

func initialize(pos):
	set_position(pos)

func activate():
	if (!active):
		active = true
		disabled = true
		emit_signal("card_picked", card_name)

func deactivate():
	emit_signal("card_decayed", card_name)
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
		set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		var p = get_parent().get_parent()
		get_parent().remove_child(self)
		p.add_child(self)
		self.set_owner(p)
