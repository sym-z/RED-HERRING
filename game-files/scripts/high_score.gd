extends Control

@export_category("Initial Characters")
@export var init_1 : Label
@export var init_2 : Label
@export var init_3 : Label
var init_arr : Array[Label] = []

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
	36: '!',
	37: '?',
	38: '.'
}
var initials : Array[int] = [0,0,0]

enum SELECTABLES {ONE,TWO,THREE,BUTTON}


var curr_selection : int = 0
var curr_label : Label 

var total_chars : int = char_dict.keys().size()

func initials_to_string() -> String:
	var retval = ""
	for letter in initials:
		retval += char_dict[letter]
	return retval
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("DPAD-DOWN"):
		decrease_char()
		pass
	elif event.is_action_pressed("DPAD-UP"):
		increase_char()
		pass
	elif event.is_action_pressed("DPAD-LEFT"):
		curr_selection += 1
		pass
	elif event.is_action_pressed("DPAD-RIGHT"):
		curr_selection += 1
		pass
	
func increase_char():
	initials[curr_selection] += 1 
	initials[curr_selection] %= total_chars
	curr_label.text = char_dict[initials[curr_selection]]
	pass
	
func decrease_char():
	initials[curr_selection] -= 1 
	if initials[curr_selection] < 0:
		initials[curr_selection] = total_chars - 1
	curr_label.text = char_dict[initials[curr_selection]]
	pass
	
func select_left():
	pass
	
func select_right():
	pass
func _ready():
	init_arr = [init_1,init_2,init_3]
	curr_label = init_arr[curr_selection]
	
	print(curr_label)
	print(initials_to_string())
