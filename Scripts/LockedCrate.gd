extends StaticBody2D

var holding_key: bool = true
const crate_scene = preload("res://Scenes/Crate.tscn")


func interaction(player: Player) -> void:
	if player.key_count > 0: #Checks if player is holding key
		player.key_count -= 1
		unlock()
	else:
		Hud.change_text("no keys :(")
		

func unlock() -> void:
	var crate = crate_scene.instance()
	crate.position = self.position
	get_tree().current_scene.add_child(crate)
	
	Hud.change_text("Crate unlocked")
	
	self.queue_free()
