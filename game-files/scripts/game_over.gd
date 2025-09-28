extends Node2D

## Holds the sound that plays when this scene starts
@export var sting : AudioStreamPlayer2D

## Holds the text for the score
@export var score_text : RichTextLabel
## Holds the text for the high score
@export var h_score_text : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_text.text = "%010d" % Globals.GAME_OVER_SCORE
	h_score_text.text = "%010d" % Globals.HIGH_SCORE
	sting.play()

func _input(event):
	if event.is_action_pressed("A") or event.is_action_pressed("B") or event.is_action_pressed("START"):
		SaveSystem.check_player_score(Globals.GAME_OVER_SCORE)
