extends Node

signal start_button_pressed
signal level_selector_button_pressed

@onready var resume = $Button/Resume
@onready var restart_level = $Button/RestartLevel


func _ready():
	MainScene.menu = self
	if MainScene.ongoing_game:
		resume.visible = 1
		restart_level.visible = 1
	else:
		resume.visible = 0
		restart_level.visible = 0



func _on_start_button_pressed():
	MainScene.load_level('story')
	MainScene.current_level = 'story'


func _on_level_selector_pressed():
	MainScene.load_level('level_selector')



func _on_resume_pressed():
	self.queue_free()


func _on_restart_level_pressed():
	MainScene.load_level(MainScene.current_level)
