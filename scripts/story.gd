extends Node2D

@onready var label = $Label

func _on_button_pressed():
	MainScene.next_level()
