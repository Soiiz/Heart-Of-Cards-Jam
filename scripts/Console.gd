extends Node

# use for scene dependent logics
var ticks = 0
var round_timer = 10
signal round_ended
signal round_started

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
		
		MusicPlayer.fade_out()
		$"../Sounds/Water".play()
		$"../UIAnim".play("fade_in")
		
		emit_signal("round_ended")
		get_tree().paused = true


func _on_CardMenu_selection_completed():
	MusicPlayer.fade_in()
	$"../Sounds/Water2".play()
	
	emit_signal("round_started")
	


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

func get_lower_spawns():
	return get_node("../Node2D/Lower_Spawns")
	
func get_magician_spawns():
	return get_node("../Node2D/Magician_Spawns")
	
func get_player():
	return get_node("../Node2D/Player")

func get_devil_spawn():
	return get_node("../Node2D/devil_spawn")
