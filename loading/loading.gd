extends Node2D

func _ready():
	print("loading ready")
	GameManager.connect("player_loaded", self, "_on_GameManager_player_loaded")

func _on_GameManager_player_loaded():
	var scene = preload("res://main/main.tscn").instance()
	get_tree().get_root().add_child(scene)
	get_tree().get_root().get_node("Loading").queue_free()
