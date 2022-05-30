extends Area2D


func interaction(player: Player) -> void:
	if overlaps_body(player):
		Global.change_level()
		
