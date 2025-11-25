extends Node

# How many scores are allowed the high score list
const ENTRY_LIMIT : int = 10
# How many names are currently in the list.
var num_entries : int = 0


# What the file will be loaded into, and saved from. This is used to make manipulating the list easier.
var high_scores_dict : Dictionary[String, int] = {}

# Names of the top scorers, sorted by score.
var sorted_names : Array[String] = []

var use_local_storage : bool = false
func _ready():
	if use_local_storage == true:
		LocalStorage.set_item("TEST", "JACKIE")
		print(LocalStorage.get_item("TEST"))
		build_scores()


## Counts entries, and loads variables.
#func initialize_list():
	#var json_scores = JSON.new()
	#json_scores.parse(LocalStorage.get_item("scores"))
	#var score_data = json_scores.data
	## Add each name and score to a dictionary.
	#for entry in score_data:
		#var score_name = str(entry)
		#var score_value = int(score_data[score_name])
		#high_scores_dict[score_name] = score_value
		#num_entries += 1
	#
	## Build array of scorers sorted by score level.
	#var blah = JSON.new()
	#blah.parse(LocalStorage.get_item("sorted"))
	#sorted_names = blah.data
	#for key in high_scores_dict.keys():
		#if sorted_names.size() == 0:
			#sorted_names.append(key)
		#else:
			#var size_before : int = sorted_names.size()
			#for i in range(sorted_names.size()):
				#var comparison_entry = sorted_names[i]
				#if high_scores_dict[comparison_entry] <= high_scores_dict[key]:
					#sorted_names.insert(i,key)
					#break
			#if size_before == sorted_names.size():
				#if sorted_names.size() < ENTRY_LIMIT:
					## List is less than ENTRY_LIMIT, just append to the end.
					#sorted_names.append(key)
				#else:
					## Couldn't add, not enough space.
					#pass
# A version of the initialize_list() function that uses built in functions in its algorithm.
func build_scores():
	# Parse current saved scores
	var json_scores = JSON.new()
	json_scores.parse(LocalStorage.get_item("scores"))
	var score_data = json_scores.data
	# Add each name and score to a dictionary.
	for entry in score_data:
		var score_name = str(entry)
		var score_value = int(score_data[score_name])
		check_file_score(score_name,score_value)
	
# Checks to see if a new score coming in should be added to the High Scores list.
func check_player_score(score : int):
	if num_entries > 0:
		# Is the new score greater than the lowest score on our high score list?
		if high_scores_dict[sorted_names.back()] < score:
			SceneTransition.score_entry()
		elif num_entries < ENTRY_LIMIT:
			# If the new score is lower than our lowest score, add it to the list at the end.
			SceneTransition.score_entry()
		else:
			# New score is not good enough to add
			SceneTransition.score_list()
			pass
	else:
		SceneTransition.score_entry()
		
func check_file_score(initials: String, score : int):
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
	LocalStorage.set_item("sorted", JSON.stringify(sorted_names))


func write_scores_to_file():
	var high_score_JSON = JSON.stringify(high_scores_dict)
	LocalStorage.set_item("scores", high_score_JSON)
