extends Control

@export var label_parent : VBoxContainer

var score_label_scene : PackedScene = preload("uid://dkb86fs451s5c")

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_score_list()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("A") or event.is_action_pressed("B") or event.is_action_pressed("START"):
		SceneTransition.main_menu()

func generate_score_list():
	for initials in SaveSystem.sorted_names:
		print("ADDING ", initials)
		var curr_label : Label = score_label_scene.instantiate()
		curr_label.set_initial_and_score(initials, SaveSystem.high_scores_dict[initials])
		label_parent.add_child(curr_label)
