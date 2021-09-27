extends Popup

onready var back_button = $BackButton
onready var next_button = $NextButton
onready var card1 = $Page/EvidenceCard1
onready var card2 = $Page/EvidenceCard2
onready var card3 = $Page/EvidenceCard3
onready var card4 = $Page/EvidenceCard4
onready var card5 = $Page/EvidenceCard5
onready var card6 = $Page/EvidenceCard6
onready var card7 = $Page/EvidenceCard7
onready var card8 = $Page/EvidenceCard8
onready var card9 = $Page/EvidenceCard9
onready var card10 = $Page/EvidenceCard10

const CARDS_PER_PAGE = 10

var deck
var current_page = 1
var cards

func _ready():
	cards = [card1,card2,card3,card4,card5,card6,card7,card8,card9,card10]
	deck = GameManager.load_deck()
	load_page()

func load_page():
	load_cards()
	update_buttons()
	
func load_cards():
	reset_cards()
	
	var range_start = (current_page - 1) * cards.size()
	var range_end = range_start + CARDS_PER_PAGE
	if range_end > deck.size() - 1:
		range_end = deck.size() - 1
	print("start: " + str(range_start) + " | end: " + str(range_end))
	for n in range(range_start, range_end):
		for card in cards:
			if not card.isPopulated:
				card.populate(deck[n])
				card.visible = true
				break

func reset_cards():
	for card in cards:
		card.unpopulate()
		card.visible = false
	
func update_buttons():
	if current_page > 1:
		back_button.disabled = false
	else:
		back_button.disabled = true
		
	if deck.size() < current_page * CARDS_PER_PAGE:
		next_button.disabled = true
	else:
		next_button.disabled = false


func _on_CloseButton_pressed():
	visible = false


func _on_BackButton_pressed():
	current_page += 1
	load_page()

func _on_NextButton_pressed():
	current_page -= 1
	load_page()
