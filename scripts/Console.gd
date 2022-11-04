extends Node

# use for scene dependent logics
var ticks = 0
var round_timer = 10
signal round_ended
signal round_started
var waves = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.console = self
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ticks += delta
	if (ticks >= round_timer):
		ticks = 0
		print("thats a round!")
		
		waves += 1
		
		MusicPlayer.fade_out()
		$"../Sounds/Water".play()
		$"../UIAnim".play("fade_in")
		
		# hide the ui and the effects
		$"../CanvasLayer/Control/CardMenu".show()
		$"../CanvasLayer2".show()
		
		emit_signal("round_ended")
		get_tree().paused = true


func _on_CardMenu_selection_completed():
	MusicPlayer.fade_in()
	$"../Sounds/Water2".play()
	$"../UIAnim".play("fade_in", -1, -2, true)
	
	emit_signal("round_started")
	
	Engine.set_time_scale(0.2)
	var tween = create_tween()
	tween.tween_property(Engine, "time_scale", 1.0, 0.5)
	
	yield($"../UIAnim", "animation_finished")
	# hide the ui and the effects
	$"../CanvasLayer/Control/CardMenu".hide()
	$"../CanvasLayer2".hide()


func game_over(source = "Unknown"):
	get_tree().set_pause(true)
	
	MusicPlayer.fade_out()
	$"../Sounds/Water".play()
	$"../UIAnim".play("game_over")
	
	var results = """
	[center]Survived %d waves[/center]
	[center]Cause of death: %s[/center]
	""" % [waves, source]
	
	$"../CanvasLayer/Control/CenterContainer2/GameOverResult".set_bbcode(results)
	
	# hide the ui and the effects
	$"../CanvasLayer/Control/CardMenu".show()
	$"../CanvasLayer2".show()
	$"../CanvasLayer/Control/CenterContainer2".show()
	


func _on_health_updated(new_health):
	for i in range(3):
		var heart = get_node("../CanvasLayer/Control/CenterContainer/HBoxContainer/Heart%d" % [i + 1])
		if i < new_health:
			heart.set_modulate(Color.red)
		elif i > new_health:
			heart.set_modulate(Color.green)
		else:
			heart.set_modulate(Color.white)

func get_center():
	return get_node("../Node2D")

func get_upper_spawns():
	return get_node("../Node2D/Upper_Spawns")

func get_left_spawns():
	return get_node("../Node2D/Left_Spawns")
	
func get_magician_spawns():
	return get_node("../Node2D/Magician_Spawns")
	
func get_player():
	return get_node("../Node2D/Player")

func get_devil_spawn():
	return get_node("../Node2D/devil_spawn")
	
func get_priestess_spawns():
	return get_node("../Node2D/Priestess_Spawns")

func dizzy(on):
	get_node("../CanvasLayer3/Control/Dizzy").set_visible(on)

func _on_UIAnim_animation_finished(anim_name):
	$"../UIAnim".play("idle")
