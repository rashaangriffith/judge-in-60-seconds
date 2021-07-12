extends Node2D

onready var title = $ReferenceRect/Title
onready var detail1 = $ReferenceRect/Detail1
onready var detail2 = $ReferenceRect/Detail2
onready var detail3 = $ReferenceRect/Detail3
onready var tween = $Tween

const UP_Y = 25
const DOWN_Y = 125

export var card_number = 0;
var isActive = false
var isTweening = false

func populate(player_card, case_deck):
#	print("populate: " + str(player_card.type))
	var card_title = GameManager.get_card_title(player_card.type)
#	print("card title: " + str(card_title))
	title.text = card_title
	
	for case_card in case_deck:
		if case_card.type == player_card.type:
			detail1.text = case_card.detail1
			detail2.text = case_card.detail2
			detail3.text = case_card.detail3

func activate():
	if isActive:
		return
		
	tween.interpolate_property(self, "position", self.position, Vector2(self.position.x, UP_Y), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()
	isActive = true
	isTweening = true

func deactivate():
	if not isActive:
		return
		
	tween.interpolate_property(self, "position", self.position, Vector2(self.position.x, DOWN_Y), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()
	isActive = false
	isTweening = true

func _on_TextureButton_pressed():
	if isTweening:
		return

	if isActive:
		deactivate()
		GameManager.deactivate_evidence_card()
	else:
		activate()
		GameManager.activate_evidence_card(card_number)


func _on_Tween_tween_all_completed():
	isTweening = false
