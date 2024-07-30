extends Node2D

var options = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var xy = Vector2(-130, -70)
	for i in MainScene.levels:
		var btn = Button.new()
		btn.position = xy
		btn.scale = (0.7, 0.7)
		
		btn.text = i
		options.append(btn)
		pass
