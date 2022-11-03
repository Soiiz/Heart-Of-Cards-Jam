extends Control

export var cards_to_spawn = 3
export var cards_to_pick = 2
var cards_picked = 0
var card_list = ["c_star", "c_sun", "c_fool", "c_chariot", "c_devil", "c_priestess", 
"c_emperor", "c_empress", "c_wof", "c_magician", "c_tower", "c_lovers", "c_hierophant", "c_temperance", "c_moon"]
var active_list = []
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
	print("spawned " + card_name)
	active_list.append(card_name)
	var instance = card.instance()
	container.add_child(instance)
	return instance
	
func spawn_card_array():
	for i in range(0, cards_to_spawn):
		var next_index = randi() % card_list.size()
		while (active_list.has(card_list[next_index])):
			next_index = randi() % card_list.size()
			if (card_list.size() - active_list.size() < cards_to_spawn):
				break
		var card_name = card_list[next_index]
		var c = spawn_card(card_name)
		c.connect("card_picked", self, "_on_card_picked")
		c.connect("card_decayed", self, "_on_card_decayed")

func _on_card_picked():
	cards_picked += 1
	if (cards_picked >= cards_to_pick):
		get_tree().paused = false
		
		emit_signal("selection_completed")

func _on_card_decayed(source = "Unknown"):
	active_list.erase(source)

func _on_Console_round_ended():
	cards_picked = 0
	spawn_card_array()


func _on_Console_round_started():
	pass # Replace with function body.
