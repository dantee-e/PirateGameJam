extends Node

var main_scene
var hud
var player

var current_level = 1

func next_level():
	current_level+=1
	print('level', str(current_level))
	main_scene.load_level(str('level', str(current_level)))
