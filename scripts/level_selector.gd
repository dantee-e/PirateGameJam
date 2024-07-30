extends Node2D

var options = []
@onready var parent_button = $ParentButton


signal level_selected(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	var xy = Vector2(0, 0)
	var j=0
	var font = load("res://assets/fonts/PixelOperator8.ttf")
	for i in MainScene.levels:
		j+=1
		if (j>4):
			j=0
			xy.y += 40
			xy.x = 0
		var btn = Button.new()
		btn.name = i
		btn.text = i
		btn.position = Vector2i(xy)
		xy = Vector2i(xy.x+120,xy.y)
		btn.set("theme_override_fonts/font", font)
		btn.pressed.connect(_on_pressed.bind(btn))
		
		options.append(btn)
		parent_button.add_child(btn)
		
func _on_pressed(button):
	MainScene.load_level(button.name)
