extends Node2D

var mugshot_head1 = preload("res://assets/sprites/mugshot_head1.png")
var mugshot_head2 = preload("res://assets/sprites/mugshot_head2.png")
var mugshot_head3 = preload("res://assets/sprites/mugshot_head3.png")
var mugshot_eyes1 = preload("res://assets/sprites/mugshot_eyes1.png")
var mugshot_eyes2 = preload("res://assets/sprites/mugshot_eyes2.png")
var mugshot_eyes3 = preload("res://assets/sprites/mugshot_eyes3.png")
var mugshot_mouth1 = preload("res://assets/sprites/mugshot_mouth1.png")
var mugshot_mouth2 = preload("res://assets/sprites/mugshot_mouth2.png")
var mugshot_mouth3 = preload("res://assets/sprites/mugshot_mouth3.png")

onready var head_sprite = $Head
onready var eyes_sprite = $Eyes
onready var mouth_sprite = $Mouth

var heads = []
var eyes = []
var mouths = []

func _ready():
	heads = [mugshot_head1, mugshot_head2, mugshot_head3]
	eyes = [mugshot_eyes1, mugshot_eyes2, mugshot_eyes3]
	mouths = [mugshot_mouth1, mugshot_mouth2, mugshot_mouth3]

func generate():
	var rng = RandomNumberGenerator.new()
	
	rng.randomize()
	head_sprite.texture = heads[rng.randi_range(0, heads.size()-1)]
	
	rng.randomize()
	eyes_sprite.texture = eyes[rng.randi_range(0, eyes.size()-1)]
	
	rng.randomize()
	mouth_sprite.texture = mouths[rng.randi_range(0, mouths.size()-1)]
