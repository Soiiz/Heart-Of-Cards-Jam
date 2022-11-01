extends Node

var default_volume = -10.0

var bgm = preload("res://sounds/moon_tower.ogg")
var last_played 


func _ready():
	set_pause_mode(Node.PAUSE_MODE_PROCESS)
	
	var a = AudioStreamPlayer.new()
	
	a.set_stream(bgm)
	
	a.set_volume_db(-50)
	a.set_bus("Music")
	a.set_autoplay(true)
	a.set_name("BGM")
	#a.connect("finished", self, "_on_finished")
	add_child(a)
	
	var t = Tween.new()
	t.set_name("Tween")
	add_child(t)
	
	# play autostart
	fade_out()
	play_music()


func play_music():
	if not $BGM.is_playing():
		$BGM.play()


func stop_music():
	$BGM.stop();


func update_EQ2(value):
	var EQ = AudioServer.get_bus_effect(1, 0)
	EQ.set_band_gain_db(2, value)

func update_EQ3(value):
	var EQ = AudioServer.get_bus_effect(1, 0)
	EQ.set_band_gain_db(3, value)

func update_EQ4(value):
	var EQ = AudioServer.get_bus_effect(1, 0)
	EQ.set_band_gain_db(4, value)

func update_EQ5(value):
	var EQ = AudioServer.get_bus_effect(1, 0)
	EQ.set_band_gain_db(5, value)


func fade_in():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($BGM, "volume_db", default_volume, 0.5)
	tween.parallel().tween_property($BGM, "pitch_scale", 1.0, 0.5)
	
	# audiobus EQ
	tween.parallel().tween_method(self, "update_EQ2", -12.4, 0, 0.5)
	tween.parallel().tween_method(self, "update_EQ3", -49.8, 0, 0.5)
	tween.parallel().tween_method(self, "update_EQ4", -60.0, 0, 0.5)
	tween.parallel().tween_method(self, "update_EQ5", -60.0, 0, 0.5)
	return tween


func fade_out():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($BGM, "volume_db", default_volume, 0.5)
	tween.parallel().tween_property($BGM, "pitch_scale", 0.5, 0.5)
	
	# audiobus EQ
	tween.parallel().tween_method(self, "update_EQ2", 0, -12.4, 0.5)
	tween.parallel().tween_method(self, "update_EQ3", 0, -49.8, 0.5)
	tween.parallel().tween_method(self, "update_EQ4", 0, -60.0, 0.5)
	tween.parallel().tween_method(self, "update_EQ5", 0, -60.0, 0.5)
	return tween
