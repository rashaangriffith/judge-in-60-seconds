extends Popup

onready var continue_button = $Background/ContinueButton
onready var view_cards_button = $Background/ViewCardsButton
onready var quit_button = $Background/QuitButton
onready var view_cards = $ViewCards

func _on_ContinueButton_pressed():
	visible = false

func _on_ViewCardsButton_pressed():
	view_cards.show()

func _on_QuitButton_pressed():
	get_tree().quit()
