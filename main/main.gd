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

var current_case_number = 1
var total_cases_number = 1
var strikes = 0
var remaining_draws = 5
var remaining_case_time = 60

var case = {}

func _ready():
	generate_case()
	populate_case()
	tween_slide_in()
	
func generate_case():
	case = {
	"perp_name": "Joe Bob",
	"crime": "Drug Sales",
	"deck": [
		{
			"type": GameManager.CARD_TYPE.ALIBI,
			"detail1": "no",
			"detail2": "",
			"detail3": "",
		},
		{
			"type": GameManager.CARD_TYPE.PRIORS,
			"detail1": "yes",
			"detail2": "petty theft",
			"detail3": "stealing candy"
		},
		{
			"type": GameManager.CARD_TYPE.WITNESS,
			"detail1": "yes",
			"detail2": "old lady",
			"detail3": "is legally blind"
		},
		{
			"type": GameManager.CARD_TYPE.PHYSICAL_EVIDENCE,
			"detail1": "no",
			"detail2": "",
			"detail3": "",
		},
		{
			"type": GameManager.CARD_TYPE.INDIVIDUAL_EVIDENCE,
			"detail1": "yes",
			"detail2": "drugs on person",
			"detail3": "",
		},
		{
			"type": GameManager.CARD_TYPE.FORENSICS,
			"detail1": "yes",
			"detail2": "substance found under fingernails",
			"detail3": "not illegal substance"
		},
	]
}

func populate_case():
	var deck = GameManager.player.deck
	case_file.populate(case)
	evidence_card_1.populate(deck[0], case.deck)
	evidence_card_2.populate(deck[1], case.deck)
	evidence_card_3.populate(deck[2], case.deck)
	evidence_card_4.populate(deck[3], case.deck)

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


func _on_Timer_timeout():
	remaining_case_time -= 1
	if remaining_case_time == 0:
		strikes += 1
		if strikes > GameManager.MAX_STRIKES:
			# game over
			pass
