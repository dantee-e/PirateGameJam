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
	MainScene.load_level('story')


func _on_level_selector_pressed():
	MainScene.load_level('level_selector')
	#level_selector_button_pressed.emit()


func _on_resume_pressed():
	self.queue_free()
