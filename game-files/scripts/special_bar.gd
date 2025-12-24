extends TextureProgressBar
@export var player :Node2D
var rotation_speed : float = 2.
# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("combo_updated", update_bar)
	player.connect("special_ready", update_bar)
	player.connect("use_special", update_bar)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += rotation_speed * delta * player.consecutive_hits
	pass
	
func update_bar():
	#print(player.consecutive_hits/player.minimum_special_charge)
	value = min(100.,(float(player.consecutive_hits)/float(player.minimum_special_charge)) * 100.)
	pass
