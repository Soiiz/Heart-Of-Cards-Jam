# Randomize Sounds Script
# By unSAME Studio (c) 2022

extends AudioStreamPlayer2D

export var pitch_low = 0.9
export var ptch_high = 1.1

export var volume_low = 0.0
export var volume_high = 0.0

export var base_volume = 0.0


# Set the audio volume and pitch to random in range
func _ready():
# warning-ignore:return_value_discarded
	connect("finished", self, "_on_finished")
	reset_parameter()


func _on_finished():
	reset_parameter()


func reset_parameter():
	randomize()
	set_volume_db(base_volume + rand_range(volume_low, volume_high))
	set_pitch_scale(rand_range(pitch_low, ptch_high))
