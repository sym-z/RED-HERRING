extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var score_debug = {
		"ASS" : 32,
	}
	var score_debug_JSON = JSON.stringify(score_debug)
	var write_score_debug = FileAccess.open("res://saves/score_debug.json", FileAccess.WRITE)
	write_score_debug.store_line(score_debug_JSON)
	write_score_debug.close()
	var read_score_debug = FileAccess.open("res://saves/score_debug.json", FileAccess.READ)
	var json = JSON.new()
	var parse_result = json.parse(read_score_debug.get_line())
	var node_data = json.data
	print(node_data)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
	#var name_list = FileAccess.open("res://saves/names/names.json", FileAccess.READ)
	#file.store_line("POOP")
	#file.close()
	#file = FileAccess.open("res://poop.txt", FileAccess.READ)
	#var string = file.get_line()
	#print(string)
	
