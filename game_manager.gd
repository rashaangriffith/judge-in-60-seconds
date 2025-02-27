extends Node

enum CARD_TYPE {
	ALIBI,
	PRIORS,
	WITNESS,
	PHYSICAL_EVIDENCE,
	INDIVIDUAL_EVIDENCE,
	FORENSICS,
	EXPERT_TESTIMONY,
	OCCUPATION,
	CHARACTER
}

signal player_loaded()
signal evidence_card_activated(card_number)
signal evidence_card_deactivated()

const MAX_STRIKES = 3

var player = {}

func start_game():
	player = load_player()
#	print("game_manager emit player loaded")
	emit_signal("player_loaded")

func load_deck():
	return [
			{
				"id": 1,
				"type": CARD_TYPE.ALIBI
			},
			{
				"id": 2,
				"type": CARD_TYPE.PRIORS
			},
			{
				"id": 3,
				"type": CARD_TYPE.WITNESS
			},
			{
				"id": 4,
				"type": CARD_TYPE.PHYSICAL_EVIDENCE
			},
			{
				"id": 5,
				"type": CARD_TYPE.INDIVIDUAL_EVIDENCE
			},
			{
				"id": 6,
				"type": CARD_TYPE.FORENSICS
			},
			{
				"id": 7,
				"type": CARD_TYPE.ALIBI
			},
			{
				"id": 8,
				"type": CARD_TYPE.PRIORS
			},
			{
				"id": 9,
				"type": CARD_TYPE.WITNESS
			},
			{
				"id": 10,
				"type": CARD_TYPE.PHYSICAL_EVIDENCE
			},
			{
				"id": 11,
				"type": CARD_TYPE.INDIVIDUAL_EVIDENCE
			},
			{
				"id": 12,
				"type": CARD_TYPE.FORENSICS
			},
			{
				"id": 13,
				"type": CARD_TYPE.ALIBI
			},
			{
				"id": 14,
				"type": CARD_TYPE.PRIORS
			},
			{
				"id": 15,
				"type": CARD_TYPE.WITNESS
			},
			{
				"id": 16,
				"type": CARD_TYPE.PHYSICAL_EVIDENCE
			},
			{
				"id": 17,
				"type": CARD_TYPE.INDIVIDUAL_EVIDENCE
			},
			{
				"id": 18,
				"type": CARD_TYPE.FORENSICS
			},
			{
				"id": 19,
				"type": CARD_TYPE.ALIBI
			},
			{
				"id": 20,
				"type": CARD_TYPE.PRIORS
			},
			{
				"id": 21,
				"type": CARD_TYPE.WITNESS
			},
			{
				"id": 22,
				"type": CARD_TYPE.PHYSICAL_EVIDENCE
			},
			{
				"id": 23,
				"type": CARD_TYPE.INDIVIDUAL_EVIDENCE
			},
			{
				"id": 24,
				"type": CARD_TYPE.FORENSICS
			},
		]

func load_player():
	return { "deck": load_deck() }

func get_card_title(type):
#	print("get_card_title: " + str(type))
#	print("alibi type: " + str(CARD_TYPE.ALIBI))
	match type:
		CARD_TYPE.ALIBI:
			return "ALIBI"
		CARD_TYPE.PRIORS:
			return "PRIORS"
		CARD_TYPE.WITNESS:
			return "WITNESS"
		CARD_TYPE.PHYSICAL_EVIDENCE:
			return "PHYSICAL"
		CARD_TYPE.INDIVIDUAL_EVIDENCE:
			return "INDIVIDUAL"
		CARD_TYPE.FORENSICS:
			return "FORENSICS"
		CARD_TYPE.EXPERT_TESTIMONY:
			return "EXPERT"
		CARD_TYPE.OCCUPATION:
			return "OCCUPATION"
		CARD_TYPE.CHARACTER:
			return "CHARACTER"

func activate_evidence_card(card_number):
	emit_signal("evidence_card_activated", card_number)
	
func deactivate_evidence_card():
#	print("gm deactive ev card")
	emit_signal("evidence_card_deactivated")
