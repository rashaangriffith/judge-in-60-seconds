extends Node2D

onready var case_file = $CaseFile
onready var evidence_card_1 = $EvidenceCard1
onready var evidence_card_2 = $EvidenceCard2
onready var evidence_card_3 = $EvidenceCard3
onready var evidence_card_4 = $EvidenceCard4
onready var tween_in = $TweenIn
onready var tween_out = $TweenOut

var CASE_FILE_OUT_Y = -150
var CASE_FILE_IN_Y = 25
var CARD_OUT_Y = 200
var CARD_IN_Y = 125

func _ready():
	tween_slide_in()

func tween_slide_in():
	tween_in.interpolate_property(case_file, "position", case_file.position, Vector2(case_file.position.x, CASE_FILE_IN_Y), 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween_in.interpolate_property(evidence_card_1, "position", evidence_card_1.position, Vector2(evidence_card_1.position.x, CARD_IN_Y), 0.75, Tween.TRANS_BACK, Tween.EASE_OUT, 0.5)
	tween_in.interpolate_property(evidence_card_2, "position", evidence_card_2.position, Vector2(evidence_card_2.position.x, CARD_IN_Y), 0.75, Tween.TRANS_BACK, Tween.EASE_OUT, 1)
	tween_in.interpolate_property(evidence_card_3, "position", evidence_card_3.position, Vector2(evidence_card_3.position.x, CARD_IN_Y), 0.75, Tween.TRANS_BACK, Tween.EASE_OUT, 1.5)
	tween_in.interpolate_property(evidence_card_4, "position", evidence_card_4.position, Vector2(evidence_card_4.position.x, CARD_IN_Y), 0.75, Tween.TRANS_BACK, Tween.EASE_OUT, 2)
	tween_in.start()

func tween_slide_out():
	tween_out.interpolate_property(case_file, "position", case_file.position, Vector2(case_file.position.x, CASE_FILE_OUT_Y), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween_out.interpolate_property(evidence_card_1, "position", evidence_card_1.position, Vector2(evidence_card_1.position.x, CARD_OUT_Y), 0.25, Tween.TRANS_BACK, Tween.EASE_IN)
	tween_out.interpolate_property(evidence_card_2, "position", evidence_card_2.position, Vector2(evidence_card_2.position.x, CARD_OUT_Y), 0.25, Tween.TRANS_BACK, Tween.EASE_IN)
	tween_out.interpolate_property(evidence_card_3, "position", evidence_card_3.position, Vector2(evidence_card_3.position.x, CARD_OUT_Y), 0.25, Tween.TRANS_BACK, Tween.EASE_IN)
	tween_out.interpolate_property(evidence_card_4, "position", evidence_card_4.position, Vector2(evidence_card_4.position.x, CARD_OUT_Y), 0.25, Tween.TRANS_BACK, Tween.EASE_IN)
	tween_out.start()


func _on_GuiltyButton_pressed():
	tween_slide_out()


func _on_TweenIn_tween_all_completed():
	pass # Replace with function body.

func _on_TweenOut_tween_all_completed():
	tween_slide_in()
