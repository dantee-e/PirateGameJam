extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D

signal gem_collected(element)

func _ready():
	if not is_connected("body_entered", _on_body_entered):
		body_entered.connect(_on_body_entered)
	if not is_in_group("gems"):
		add_to_group("gems")
		

func _on_body_entered(body):
	if body is CharacterBody2D:
		animation_player.play("collected")
		
		match name:
			'WaterGem':
				print('emitindo watergem')
			'FireGem':
				print('emitindo firegem')
				gem_collected.emit(2)
			'EarthGem':
				gem_collected.emit(3)
			'AirGem':
				gem_collected.emit(4)
