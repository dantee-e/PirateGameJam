extends Node

var main_scene
var hud
var player

var ongoing_game = 0
var current_level = 0

var levels = ['story','level1', 'level2', 'level3', 'level4', 'endscreen']
var completed_levels = 0
# adicionar opcao de custom tilemaps

func next_level():
	if !ongoing_game:
		ongoing_game=1
	current_level+=1
	main_scene.load_level(levels[current_level])
	

func load_menu():
	main_scene.show_menu()

func hide_menu():
	main_scene.hide_menu()
