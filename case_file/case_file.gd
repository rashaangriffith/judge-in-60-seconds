extends Node2D

onready var perp_name = $ReferenceRect/Name
onready var crime = $ReferenceRect/Crime
onready var when = $ReferenceRect/When
onready var where = $ReferenceRect/Where

func populate(data):
	perp_name.text = data.first_name + " " + data.last_name
	crime.text = data.crime
	when.text = str(data.when)
	where.text = data.where
