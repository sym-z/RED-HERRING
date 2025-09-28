extends Label
@export var up_arrow : TextureRect
@export var down_arrow : TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_arrow_vis(new_vis : bool):
	up_arrow.visible = new_vis
	down_arrow.visible = new_vis
