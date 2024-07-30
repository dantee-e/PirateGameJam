extends Node

signal start_button_pressed
signal level_selector_button_pressed

@onready var resume = $Resume

func _ready():
	MainScene.menu = self
	if MainScene.ongoing_game:
		resume.visible = 1
	else:
		resume.visible = 0



func _on_start_button_pressed():
	MainScene.next_level()


func _on_level_selector_pressed():
	level_selector_button_pressed.emit()


func _on_resume_pressed():
	MainScene.hide_menu()
