extends Node2D

onready var case_file = $CaseFile
onready var evidence_card_1 = $EvidenceCard1
onready var evidence_card_2 = $EvidenceCard2
onready var evidence_card_3 = $EvidenceCard3
onready var evidence_card_4 = $EvidenceCard4
onready var tween_in = $TweenIn
onready var tween_out = $TweenOut
onready var tween_out_draw = $TweenOutDraw
onready var tween_in_draw = $TweenInDraw
onready var draw_button = $DrawButton
onready var draws_label = $DrawsLabel

const HAND_SIZE = 4
const MAX_DRAWS = 5
const CASE_FILE_OUT_Y = -150
const CASE_FILE_IN_Y = 25
const CARD_OUT_Y = 200
const CARD_IN_Y = 125

var current_case_number = 1
var total_cases_number = 1
var strikes = 0
var remaining_draws = MAX_DRAWS
var remaining_case_time = 60
var active_evidence_card

var case = {}
var pool = []
var hand = []

func _ready():
	evidence_card_1.connect("activated", self, "_on_Evidence_Card_1_activated")
	evidence_card_2.connect("activated", self, "_on_Evidence_Card_2_activated")
	evidence_card_3.connect("activated", self, "_on_Evidence_Card_3_activated")
	evidence_card_4.connect("activated", self, "_on_Evidence_Card_4_activated")
	GameManager.connect("evidence_card_activated", self, "_on_GameManager_evidence_card_activated")
	GameManager.connect("evidence_card_deactivated", self, "_on_GameManager_evidence_card_deactivated")
	
	if (GameManager.player.deck.size() - HAND_SIZE) > MAX_DRAWS:
		remaining_draws = MAX_DRAWS
	else:
		remaining_draws = GameManager.player.deck.size() - HAND_SIZE
	draws_label.text = "DRAWS: " + str(remaining_draws)
	
	generate_case()
	populate_case()
	tween_slide_in()
	
func generate_case():
	pool = GameManager.player.deck.duplicate(true)
	for n in 4:
		draw_card(n)

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var first_name = CaseData.first_names[rng.randi_range(0, CaseData.first_names.size() - 1)]
	rng.randomize()
	var last_name = CaseData.last_names[rng.randi_range(0, CaseData.last_names.size() - 1)]
	rng.randomize()
	var crime = CaseData.crimes[rng.randi_range(0, CaseData.crimes.size() - 1)]
	rng.randomize()
	var is_guilty = rng.randi_range(0, 1) == 0
	
	case = {
		"first_name": first_name,
		"last_name": last_name,
		"crime": crime,
		"is_guilty": is_guilty,
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

func draw_card(index):
	var pool_count = pool.size()
	print("draw card pool count: " + str(pool_count))
	print("draw card player deck count: " + str(GameManager.player.deck.size()))
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var pool_index = rng.randi_range(0, pool_count - 1)
	hand.insert(index, pool[pool_index])
	pool.remove(pool_index)
	

func populate_case():
	var deck = GameManager.player.deck
	case_file.populate(case)
	for n in 4:
		populate_evidence_card(n)

func populate_evidence_card(hand_index):
	if hand_index == 0:
		evidence_card_1.populate(hand[hand_index], case.deck)
	elif hand_index == 1:
		evidence_card_2.populate(hand[hand_index], case.deck)
	elif hand_index == 2:
		evidence_card_3.populate(hand[hand_index], case.deck)
	elif hand_index == 3:
		evidence_card_4.populate(hand[hand_index], case.deck)

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

func _on_TweenIn_tween_all_completed():
	pass # Replace with function body.

func _on_TweenOut_tween_all_completed():
	generate_case()
	populate_case()
	tween_slide_in()


func _on_Timer_timeout():
	remaining_case_time -= 1
	if remaining_case_time == 0:
		strikes += 1
		if strikes > GameManager.MAX_STRIKES:
			# game over
			pass

func _on_GameManager_evidence_card_activated(card_number):
	if card_number == 1:
		evidence_card_2.deactivate()
		evidence_card_3.deactivate()
		evidence_card_4.deactivate()
		active_evidence_card = evidence_card_1
	elif card_number == 2:
		evidence_card_1.deactivate()
		evidence_card_3.deactivate()
		evidence_card_4.deactivate()
		active_evidence_card = evidence_card_2
	elif card_number == 3:
		evidence_card_1.deactivate()
		evidence_card_2.deactivate()
		evidence_card_4.deactivate()
		active_evidence_card = evidence_card_3
	elif card_number == 4:
		evidence_card_1.deactivate()
		evidence_card_2.deactivate()
		evidence_card_3.deactivate()
		active_evidence_card = evidence_card_4
	
	if remaining_draws > 0:
		draw_button.disabled = false

func _on_GameManager_evidence_card_deactivated():
	print("card deactivated")
	draw_button.disabled = true

func _on_DrawButton_pressed():
	tween_out_draw.interpolate_property(active_evidence_card, "position", active_evidence_card.position, Vector2(active_evidence_card.position.x, CARD_OUT_Y), 0.25, Tween.TRANS_BACK, Tween.EASE_IN)
	tween_out_draw.start()
	remaining_draws -= 1
	draws_label.text = "DRAWS: " + str(remaining_draws)
	if remaining_draws == 0:
		draw_button.disabled = true

func _on_TweenOutDraw_tween_all_completed():
	var index = active_evidence_card.card_number - 1
	hand.remove(index)
	draw_card(index)
	populate_evidence_card(index)
	tween_in_draw.interpolate_property(active_evidence_card, "position", active_evidence_card.position, Vector2(active_evidence_card.position.x, active_evidence_card.UP_Y), 0.75, Tween.TRANS_BACK, Tween.EASE_OUT, 0.5)
	tween_in_draw.start()

func _on_TweenInDraw_tween_all_completed():
	pass

func _on_GuiltyButton_pressed():
	tween_slide_out()

func _on_NotGuiltyButton_pressed():
	tween_slide_out()
