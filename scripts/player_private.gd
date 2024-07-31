extends CharacterBody2D



func _on_tree_exited():
	MainScene.player = null
