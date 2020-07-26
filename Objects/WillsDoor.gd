extends "res://Objects/Door.gd"

func _on_body_entered(body):
	if Event.events[Event.WILLS_DOOR_UNLOCKED]:
		._on_body_entered(body)
	else:
		Event.display_text("Hmm... the door appears to be locked...")
		Event.display_text("Ok, picked the lock!")
		Event.events[Event.WILLS_DOOR_UNLOCKED] = true
