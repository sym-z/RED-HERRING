extends Label
@export var divider : String = "    "

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_initial_and_score(initial : String, score : int):
	text = initial + divider + str(score)
	pass
