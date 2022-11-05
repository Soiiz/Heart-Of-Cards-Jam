extends "res://cards/Card.gd"

export(PackedScene) var proj_scene
var locked = false
var player = console.get_player()
var anchor
var orb_b
var orb_w
export var orbit = 300
export var anchor_speed = 4.0
var time = 0
export var lock_rate = 4.0
export var unlock_rate = 2.0
var lock_time = 0
export var rot_speed_max = 1 * PI
var rot_speed = rot_speed_max

func activate():
	.activate()
	anchor = Node2D.new()
	console.get_center().add_child(anchor)
	anchor.position = player.position
	orb_b = proj_scene.instance()
	anchor.add_child(orb_b)
	orb_b.init(orbit)
	orb_w = proj_scene.instance()
	anchor.add_child(orb_w)
	orb_w.init(-orbit)
	
func _process(delta):
	if (active):
		time += delta
		anchor.rotation += rot_speed * delta
		if (round_lifetime >= round_duration):
			deactivate()
		elif !(get_tree().paused):
			lock_time += delta
			if !locked:
				anchor.position = anchor.position.linear_interpolate(player.position, anchor_speed * delta)
				rot_speed = min(rot_speed_max, (rot_speed + 0.1) * 1.2)
				if lock_time >= lock_rate:
					locked = true
					lock_time = 0
					orb_b.invert(true)
					orb_w.invert(true)
			else:
				rot_speed = max(0, (rot_speed * 0.8) - 0.5)
				
				if lock_time >= unlock_rate:
					locked = false
					lock_time = 0
					orb_b.invert(false)
					orb_w.invert(false)
				

func deactivate():
	if (anchor):
		anchor.queue_free()
	.deactivate()
