extends Node2D

func _on_StartButton_pressed():
	var scene = preload("res://loading/loading.tscn").instance()
	get_tree().get_root().add_child(scene)
	GameManager.start_game()
	get_tree().get_root().get_node("MainMenu").queue_free()
