extends CPUParticles2D


var pos = Vector2.ZERO

func _ready():
	var card_name = get_parent().get_script().get_path().get_slice("/", 3)
	print("res://arts/cards/%s.png" % card_name)
	set_texture(load("res://arts/cards/%s.png" % card_name))
	set_emitting(true)
	
	#pos = get_global_position()

func _process(delta):
	set_global_scale(Vector2(1, 1))
	set_global_rotation(0)
	#set_global_position(pos)

func _on_Timer_timeout():
	queue_free()
