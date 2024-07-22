extends Area2D

@onready var animation_player = $AnimationPlayer

signal gem_collected(element)

func _on_body_entered(body):
	if body is CharacterBody2D:
		animation_player.play("collected")
		print(name)
		match name:
			'WaterGem':
				gem_collected.emit(1)
			'FireGem':
				gem_collected.emit(2)
			'EarthGem':
				gem_collected.emit(3)
			'AirGem':
				gem_collected.emit(4)
