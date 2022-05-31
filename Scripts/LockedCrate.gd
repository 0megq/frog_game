extends StaticBody2D

var holding_key: bool = true
const crate_scene = preload("res://Scenes/Crate.tscn")


func interaction(player: Player) -> void:
	if player.key_count > 0: #Checks if player is holding key
		unlock()
		player.key_count -= 1
	else:
		print("no keys :(")
		


func unlock() -> void:
	var crate = crate_scene.instance()
	crate.position = self.position
	get_tree().current_scene.add_child(crate)
	self.queue_free()
