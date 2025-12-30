extends TextureProgressBar
@export var player :Node2D
var rotation_speed : float = 2.
var using_special : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("combo_updated", update_bar)
	player.connect("special_ready", update_bar)
	#player.connect("use_special", update_bar)
	player.connect("use_special", special_effect)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("SPECIAL") and player.consecutive_hits >= player.minimum_special_charge:
		using_special = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += rotation_speed * delta * player.consecutive_hits
	#print(using_special)
	pass
	
func update_bar():
	#print(player.consecutive_hits/player.minimum_special_charge)
	print("using special = ", using_special)
	if using_special == false:
		print("RESETTING")
		value = min(100.,(float(player.consecutive_hits)/float(player.minimum_special_charge)) * 100.)
	else:
		print("blocked reset")
	pass
var tween : Tween
func special_effect():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.bind_node(self)
	tween.tween_property(self,"scale",scale*5, 1.0)
	tween.tween_property(self, "modulate", Color(1,1,1,0),0.2)
	tween.tween_callback(reset_special_effect)
	tween.play()
	pass
func reset_special_effect():
	if tween:
		tween.kill()
	scale = Vector2(1.0,1.0)
	modulate = Color(1,1,1,1)
	using_special = false
	update_bar()
	pass
