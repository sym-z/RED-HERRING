extends Control

@export_category("Initial Characters")
@export var init_1 : Label
@export var init_2 : Label
@export var init_3 : Label

@export_category("Submit Label")
@export var submit : Label
# Each initial label
var label_arr : Array[Label] = []

var char_dict : Dictionary[int,String] = {
	0: 'A',
	1: 'B',
	2: 'C',
	3: 'D',
	4: 'E',
	5: 'F',
	6: 'G',
	7: 'H',
	8: 'I',
	9: 'J',
	10: 'K',
	11: 'L',
	12: 'M',
	13: 'N',
	14: 'O',
	15: 'P',
	16: 'Q',
	17: 'R',
	18: 'S',
	19: 'T',
	20: 'U',
	21: 'V',
	22: 'W',
	23: 'X',
	24: 'Y',
	25: 'Z',
	26: '0',
	27: '1',
	28: '2',
	29: '3',
	30: '4',
	31: '5',
	32: '6',
	33: '7',
	34: '8',
	35: '9',
	36: '.',
	37: '-',
	38: '_',
	39: '!',
	40: '?',
}
# Char dict encoding of initials
var initials : Array[int] = [0,0,0]

# Which selection out of initials and submit button we are selecting
var curr_selection : int = 0
# What label we are selecting
var curr_label : Label 

var total_chars : int = char_dict.keys().size()

enum SELECTIONS {INIT_1,INIT_2,INIT_3,SUBMIT}

var debug : bool = false


func initials_to_string() -> String:
	var retval = ""
	for letter in initials:
		retval += char_dict[letter]
	return retval
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("DPAD-DOWN"):
		decrease_char()
	elif event.is_action_pressed("DPAD-UP"):
		increase_char()
	elif event.is_action_pressed("DPAD-LEFT"):
		select_left()
	elif event.is_action_pressed("DPAD-RIGHT"):
		select_right()
	elif event.is_action_pressed("A") or event.is_action_pressed("B"):
		if curr_selection < SELECTIONS.SUBMIT:
			select_right()
		else:
			choice_selection()
	elif event.is_action_pressed("SELECT"):
		select_right()
	elif event.is_action_pressed("START"):
		if curr_selection == SELECTIONS.SUBMIT:
			choice_selection()
		else:
			while curr_selection < SELECTIONS.SUBMIT:
				select_left()
	
func increase_char():
	if curr_selection != SELECTIONS.SUBMIT:
		initials[curr_selection] += 1 
		initials[curr_selection] %= total_chars
		curr_label.text = char_dict[initials[curr_selection]]
	
func decrease_char():
	if curr_selection != SELECTIONS.SUBMIT:
		initials[curr_selection] -= 1 
		if initials[curr_selection] < 0:
			initials[curr_selection] = total_chars - 1
		curr_label.text = char_dict[initials[curr_selection]]
	
func select_left():
	curr_selection -= 1
	if curr_selection < 0:
		curr_selection = label_arr.size() - 1
	curr_label = label_arr[curr_selection]
	if curr_selection == SELECTIONS.SUBMIT:
		label_arr[SELECTIONS.SUBMIT].text = "DONE?"
	else:
		label_arr[SELECTIONS.SUBMIT].text = "     "
	set_arrows()
	
func select_right():
	curr_selection += 1
	if curr_selection >= label_arr.size():
		curr_selection = 0
	curr_label = label_arr[curr_selection]
	if curr_selection == SELECTIONS.SUBMIT:
		label_arr[SELECTIONS.SUBMIT].text = "DONE?"
	else:
		label_arr[SELECTIONS.SUBMIT].text = "     "
	set_arrows()

# Reveals arrows over current selection
func set_arrows():
	init_1.set_arrow_vis(false)
	init_2.set_arrow_vis(false)
	init_3.set_arrow_vis(false)
	match curr_selection:
		SELECTIONS.INIT_1:
			init_1.set_arrow_vis(true)
			pass
		SELECTIONS.INIT_2:
			init_2.set_arrow_vis(true)
			pass
		SELECTIONS.INIT_3:
			init_3.set_arrow_vis(true)
			pass
		SELECTIONS.SUBMIT:
			pass

# Player has finished setting initials and has hit submit. 
func choice_selection():
	if curr_selection == SELECTIONS.SUBMIT and debug == false:
		# SEND INFO TO SAVE SYSTEM
		SaveSystem.add_score(initials_to_string(), Globals.GAME_OVER_SCORE)
		#TODO: Overwrite score json
		SaveSystem.write_scores_to_file()
		# Send to list of high scores
		SceneTransition.score_list()
		pass

func _ready():
	label_arr = [init_1,init_2,init_3,submit]
	curr_label = label_arr[curr_selection]
	set_arrows()
	label_arr[SELECTIONS.SUBMIT].text = "     "
