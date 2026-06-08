extends Node

var enemies_killed = 0

func restart_game():
	enemies_killed = 0
	get_tree().call_deferred("reload_current_scene")
