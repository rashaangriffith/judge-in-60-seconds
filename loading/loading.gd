extends Node2D

var next_scene = "" setget set_next_scene, get_next_scene

func _ready():
#	print("loading ready")
	GameManager.connect("player_loaded", self, "_on_GameManager_player_loaded")

func _on_GameManager_player_loaded():
	var scene
	if next_scene == "Main":
		scene = preload("res://main/main.tscn").instance()
	elif next_scene == "ViewCards":
		scene = preload("res://view_cards/view_cards.tscn").instance()
	get_tree().get_root().add_child(scene)
	get_tree().get_root().get_node("Loading").queue_free()
	
func set_next_scene(value):
	next_scene = value

func get_next_scene():
	return next_scene
