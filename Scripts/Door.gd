extends Area2D

onready var Main: Node2D = get_tree().current_scene


func interaction(player: Player) -> void:
	if overlaps_body(player):
		if Main.crate_count == 0:
			Global.change_level()
		else:
			print(str(Main.crate_count) + " frogs left to save. Don't leave them to rot.")
		
