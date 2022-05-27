extends StaticBody2D

var holding_key: bool = true
const crate_scene = preload("res://Scenes/Crate.tscn")

func interaction() -> void:
	if holding_key: #Checks if player is holding key
		unlock()


func unlock() -> void:
	var crate = crate_scene.instance()
	crate.position = self.position
	get_tree().root.add_child(crate)
	self.queue_free()
