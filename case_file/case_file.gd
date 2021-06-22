extends Node2D

onready var perp_name = $ReferenceRect/Name
onready var crime = $ReferenceRect/Crime

func populate(data):
	perp_name.text = data.first_name + " " + data.last_name
	crime.text = data.crime
