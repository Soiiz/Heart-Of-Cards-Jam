extends CPUParticles2D


var pos = Vector2.ZERO

func _ready():
	# pause parent before flying out
	get_parent().set_process(false)
	get_parent().set_physics_process(false)
	
	var card_name = get_parent().get_script().get_path().get_slice("/", 3)
	
	#special case star [TODO]
	if card_name == "c_star":
		card_name = get_parent().source
		card_name = "c_star"
	
	print("res://arts/cards/%s.png" % card_name)
	set_texture(load("res://arts/cards/%s.png" % card_name))
	set_emitting(true)
	
	#pos = get_global_position()

func _process(delta):
	set_global_scale(Vector2(1, 1))
	set_global_rotation(0)
	#set_global_position(pos)

func _on_Timer_timeout():
	# unpause parent
	get_parent().set_physics_process(true)
	get_parent().set_process(true)
	
	queue_free()
