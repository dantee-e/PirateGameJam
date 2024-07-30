extends Area2D

@onready var animation_player = $AnimationPlayer

signal gem_collected(element)

func _ready():
	if not is_in_group("gems"):
		add_to_group("gems")

func _on_body_entered(body):
	if body is CharacterBody2D:
		animation_player.play("collected")
		match name:
			'WaterGem':
				gem_collected.emit(1)
			'FireGem':
				gem_collected.emit(2)
			'EarthGem':
				gem_collected.emit(3)
			'AirGem':
				gem_collected.emit(4)
