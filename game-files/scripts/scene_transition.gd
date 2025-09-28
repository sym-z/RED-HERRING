extends Node

var main_menu_scene : String = "uid://b1obfcxhn54mx"
var level_scene : String = "uid://d164o0t7vod04"
var high_score_entry_scene : String = "uid://ctaseihks685x"
var high_score_list_scene : String = "uid://bdhmks47m8kpq"
var game_over_scene : String = "uid://bxgagyqbvaspe"

func main_menu():
	call_deferred("change_scene", main_menu_scene)

func level():
	call_deferred("change_scene", level_scene)
	
func score_entry():
	call_deferred("change_scene", high_score_entry_scene)

func score_list():
	call_deferred("change_scene", high_score_list_scene)
	
func game_over():
	call_deferred("change_scene", game_over_scene)
	
func change_scene(scene:String):
	get_tree().change_scene_to_file(scene)
