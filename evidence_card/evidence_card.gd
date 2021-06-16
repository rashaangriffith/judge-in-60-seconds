extends Node2D

onready var title = $ReferenceRect/Title
onready var detail1 = $ReferenceRect/Detail1
onready var detail2 = $ReferenceRect/Detail2
onready var detail3 = $ReferenceRect/Detail3
onready var tween = $Tween

const UP_Y = 25
const DOWN_Y = 125

var isUp = false

func populate(player_card, case_deck):
	var card_title = GameManager.get_card_title(player_card.type)
	title.text = card_title
	
	for case_card in case_deck:
		if case_card.type == player_card.type:
			if case_card.detail1:
				detail1.text = case_card.detail1
			if case_card.detail2:
				detail2.text = case_card.detail2
			if case_card.detail3:
				detail3.text = case_card.detail3

func _on_TextureButton_pressed():
	var end_y_pos = UP_Y
	if isUp:
		end_y_pos = DOWN_Y
		isUp = false
	else:
		isUp = true
	tween.interpolate_property(self, "position", self.position, Vector2(self.position.x, UP_Y), 1, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()
