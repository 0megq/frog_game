extends Area2D


func interaction(player: Player) -> void:
	if overlaps_body(player):
		if Global.crate_count == 0:
			Global.change_level()
		else:
			print(str(Global.crate_count) + " frogs left to save. Don't leave them to rot.")
		
