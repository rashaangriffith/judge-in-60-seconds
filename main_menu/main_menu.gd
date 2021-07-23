extends Node2D

onready var view_cards_button = $Background/ViewCardsButton

func _on_StartButton_pressed():
	var scene = preload("res://loading/loading.tscn").instance()
	scene.next_scene = "Main"
	get_tree().get_root().add_child(scene)
	GameManager.start_game()
	get_tree().get_root().get_node("MainMenu").queue_free()


func _on_ViewCardsButton_pressed():
	var scene = preload("res://loading/loading.tscn").instance()
	scene.next_scene = "ViewCards"
	get_tree().get_root().add_child(scene)
	GameManager.start_game()
	get_tree().get_root().get_node("MainMenu").queue_free()
