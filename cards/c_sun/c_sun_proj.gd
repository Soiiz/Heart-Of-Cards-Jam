extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target_scale
export var first_active_time = 1
export var active_time = 1 / 60
var lifetime_max = first_active_time + active_time + 0.5
var lifetime = 0
var active_ratio = 1 / first_active_time
var active = false
var ready = false
var startup = 0
var startup_time = 0
var hit_player

# Called when the node enters the scene tree for the first time.
func _ready():
	if (startup <= 0):
		ready = true
	hit_player = false
func init(pos, _scale, rot, _startup):
	position = pos
	scale = Vector2(0, _scale.y)
	target_scale = _scale
	rotation = rot
	startup = _startup
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (ready):
		lifetime += delta
		var s = scale
		if (lifetime < first_active_time):
			s.x = lerp(s.x, target_scale.x / 2, active_ratio)
		elif (lifetime < first_active_time + active_time):
			s.x = lerp(s.x, target_scale.x, 1)
		else:
			s.x = lerp(s.x, 0, 0.2)
		if (lifetime >= first_active_time && lifetime < first_active_time + active_time):
			active = true
		else:
			active = false
		
		scale = s
		
		if (lifetime > lifetime_max):
			queue_free()
	else:
		startup_time += delta
		var s = scale
		s.x = lerp(s.x, 0.1, 0.2)
		scale = s
		if (startup_time >= startup):
			ready = true


func _on_Area2D_area_entered(area):
	if area.is_in_group("player") && active && !hit_player:
		area.take_damage(1)
		hit_player = true
