extends Node
var housetear_collected = false
var game_pause = true


var current_scene = "house"
var transition_scene = false

var player_exit_house_posx = 292
var player_exit_house_posy = 172

var player_start_posx = 13
var player_start_posy = 33

var game_first_loadin = true


func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "house":
			current_scene = "world"
		else:
			current_scene = "house"
