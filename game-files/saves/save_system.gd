extends Node

# How many scores are on the high score list
const ENTRY_LIMIT : int = 10
var num_entries : int = 0

var read_score_file : FileAccess

var write_score_file : FileAccess

# What the file will be loaded into, and saved from. This is used to make manipulating the list easier.
var high_scores_dict : Dictionary[String, int] = {}

# Names of the top scorers, sorted by score.
var sorted_names : Array[String] = []

func _ready():
	#debug_save_system()
	initialize_list()
	check_new_score("BOOB", 1000)
	check_new_score("BUTTO", 1200)
	check_new_score("CORN", 4000)
	check_new_score("B0O", 2200)
	check_new_score("BOWL", 1040)
	check_new_score("BBL", 1200)
	check_new_score("BONK", 1230)
	check_new_score("THRO", 1205)
	print_save_state()
	pass

func debug_save_system():
	# SAVE
	var score_debug = {
		"ASS" : 32,
		"POOP" : 420,
	}
	var score_debug_JSON = JSON.stringify(score_debug)
	var write_score_debug = FileAccess.open("res://saves/score_debug.json", FileAccess.WRITE)
	write_score_debug.store_line(score_debug_JSON)
	write_score_debug.close()
	# LOAD
	var read_score_debug = FileAccess.open("res://saves/score_debug.json", FileAccess.READ)
	var json = JSON.new()
	var parse_result = json.parse(read_score_debug.get_line())
	var node_data = json.data
	print(node_data)
	read_score_debug.close()

# Counts entries, and loads variables.
func initialize_list():
	# Parse current saved scores
	read_score_file = FileAccess.open("res://saves/score_debug.json", FileAccess.READ)
	## Including this line messes things up, I think i can only write and read to one file before closing.
	#write_score_file = FileAccess.open("res://saves/score_debug.json", FileAccess.WRITE)
	
	var json_scores = JSON.new()
	json_scores.parse(read_score_file.get_line())
	var score_data = json_scores.data
	# Add each name and score to a dictionary.
	for entry in score_data:
		#print(entry)
		#print(score_data[str(entry)])
		var score_name = str(entry)
		var score_value = int(score_data[score_name])
		high_scores_dict[score_name] = score_value
		num_entries += 1
	
	# Build array of scorers sorted by score level.
	#print("KEYS: ", high_scores_dict.keys())
	for key in high_scores_dict.keys():
		if sorted_names.size() == 0:
			sorted_names.append(key)
			#print("ADDING TO ZERO: ", key)
		else:
			var size_before : int = sorted_names.size()
			for i in range(sorted_names.size()):
				var comparison_entry = sorted_names[i]
				if high_scores_dict[comparison_entry] <= high_scores_dict[key]:
					sorted_names.insert(i,key)
					#print("INSERTING IN PLACE: ", key)
					break
			if size_before == sorted_names.size():
				if sorted_names.size() < ENTRY_LIMIT:
					# List is less than ENTRY_LIMIT, just append to the end.
					sorted_names.append(key)
					#print("ADDING ANYWAY: ", key)
				else:
					# Couldn't add, not enough space.
					pass
	#print(sorted_names)

func build_scores():
	# Parse current saved scores
	read_score_file = FileAccess.open("res://saves/score_debug.json", FileAccess.READ)
	## Including this line messes things up, I think i can only write and read to one file before closing.
	#write_score_file = FileAccess.open("res://saves/score_debug.json", FileAccess.WRITE)
	
	var json_scores = JSON.new()
	json_scores.parse(read_score_file.get_line())
	var score_data = json_scores.data
	# Add each name and score to a dictionary.
	for entry in score_data:
		#print(entry)
		#print(score_data[str(entry)])
		var score_name = str(entry)
		var score_value = int(score_data[score_name])
		check_new_score(score_name,score_value)
	pass
	
#TODO: Try to make score initialization use these functions.
# Checks to see if a new score coming in can be added to the High Scores list.
func check_new_score(initials: String, score : int):
	if num_entries > 0:
		# Is the new score greater than the lowest score on our high score list?
		if high_scores_dict[sorted_names.back()] < score:
			add_score(initials,score)
		elif num_entries < ENTRY_LIMIT:
			# If the new score is lower than our lowest score, add it to the list at the end.
			add_score(initials,score)
		else:
			# New score is not good enough to add
			pass
	else:
		add_score(initials, score)

# Adds new name and high score to list.
func add_score(initials : String, score : int):
	if num_entries > 0:
		# Is new score the highest?
		if score > high_scores_dict[sorted_names.front()]:
			# Add to the front
			sorted_names.insert(0,initials)
		# Is the new score the lowest?
		elif score < high_scores_dict[sorted_names.back()]:
			# Insert at back 
			sorted_names.append(initials)
		else:
			# Iterate and find the correct position
			for i in range(sorted_names.size()):
				var comp = sorted_names[i]
				if high_scores_dict[comp] < score:
					sorted_names.insert(i,initials)
					break
		high_scores_dict[initials] = score
		num_entries += 1
		# Did list go over capacity? If so, delete from end.
		if sorted_names.size() > ENTRY_LIMIT:
			var del_name = sorted_names.back()
			sorted_names.pop_back()
			high_scores_dict.erase(del_name)
			num_entries -= 1
	# Add the first entry to the high score list.
	else:
		high_scores_dict[initials] = score
		sorted_names.append(initials)
		num_entries += 1

func print_save_state():
	print(high_scores_dict)
	print(sorted_names)
