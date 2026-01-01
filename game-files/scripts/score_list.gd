extends Control

@export var label_parent : VBoxContainer

var score_label_scene : PackedScene = preload("uid://dkb86fs451s5c")

var debug : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if debug == false:
		generate_score_list()
	else:
		generate_debug_list()

func _input(event):
	if event.is_action_pressed("A") or event.is_action_pressed("B") or event.is_action_pressed("START"):
		SceneTransition.main_menu()

func generate_score_list():
	for initials in SaveSystem.sorted_names:
		print("ADDING ", initials)
		var curr_label : Label = score_label_scene.instantiate()
		curr_label.set_initial_and_score(initials, SaveSystem.high_scores_dict[initials])
		label_parent.add_child(curr_label)

func generate_debug_list():
	for i in range(10):
		var curr_label : Label = score_label_scene.instantiate()
		curr_label.set_initial_and_score("AAA\t", 9999)
		label_parent.add_child(curr_label)
