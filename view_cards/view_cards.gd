extends Popup

onready var back_button = $BackButton
onready var next_button = $NextButton

const CARDS_PER_PAGE = 10

var deck
var current_page = 1

func _ready():
	deck = GameManager.load_deck()
	update_buttons()
	
#func load_cards():
#	for n in range():
		
func update_buttons():
	if current_page > 1:
		back_button.disabled = false
	else:
		back_button.disabled = true
		
	if deck.size() <= current_page * CARDS_PER_PAGE:
		next_button.disabled = true
	else:
		next_button.disabled = false


func _on_CloseButton_pressed():
	visible = false
