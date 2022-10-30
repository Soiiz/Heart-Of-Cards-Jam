extends Control

export var cards_to_spawn = 3
export var cards_to_pick = 2
var cards_picked = 0
var card_list = ["c_star", "c_sun", "c_fool", "c_chariot", "c_devil", "c_priestess"]
var card
onready var container = $CenterContainer/HBoxContainer
signal selection_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_card_array()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	pass

func spawn_card(card_name):
	card = load("res://cards/" + card_name + "/" + card_name + ".tscn")
	var instance = card.instance()
	container.add_child(instance)
	return instance
	
func spawn_card_array():
	for i in range(0, cards_to_spawn):
		var card_name = card_list[(randi() % card_list.size())]
		var c = spawn_card(card_name)
		c.connect("card_picked", self, "_on_card_picked")

func _on_card_picked():
	cards_picked += 1
	if (cards_picked >= cards_to_pick):
		get_tree().paused = false
		
		# hide the ui and the effects
		hide()
		$"../../../CanvasLayer2".hide()
		
		emit_signal("selection_completed")


func _on_Console_round_ended():
	show()
	$"../../../CanvasLayer2".show()
	
	cards_picked = 0
	spawn_card_array()


func _on_Console_round_started():
	pass # Replace with function body.
