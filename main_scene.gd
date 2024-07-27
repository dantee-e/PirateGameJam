extends Node

@onready var menu = $Menu
@onready var hud = $HUD
@onready var main_2d = $Main2D


var level_instance

func _ready():
	Global.main_scene = self


func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	if is_instance_valid(menu):
		menu.queue_free()
	level_instance = null

func load_level(level_name : String):
	unload_level()
	var level_path = "res://Levels/%s.tscn" %level_name
	var level_resource = load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		main_2d.call_deferred("add_child", level_instance)

func _on_start_button_pressed():
	load_level("level1")
