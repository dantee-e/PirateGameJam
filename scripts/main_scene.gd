extends Node


@onready var hud
@onready var menu
var main_2d


var player

var levels = ['story','level1', 'level2', 'level3', 'level4', 'endscreen']
var completed_levels = 0
var ongoing_game = 0
var current_level = 0

var level_instance

func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	hide_menu()
	level_instance = null

func load_level(level_name : String):
	unload_level()
	var level_path = "res://Levels/%s.tscn" %level_name
	var level_resource = load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		main_2d.call_deferred("add_child", level_instance)

func load_menu():
	load_level('menu')

func hide_menu():
	if(is_instance_valid(menu)):
		menu.queue_free()

	
func next_level():
	if !ongoing_game:
		ongoing_game=1
	current_level+=1
	load_level(levels[current_level])
	

func _on_menu_level_selector_button_pressed():
	load_level('level_selector')


func _on_main_2d_ready():
	main_2d = $Main2D
