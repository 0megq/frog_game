extends StaticBody2D

const frog_scene = preload("res://Scenes/PinkFrog.tscn")

func interaction(player: Player) -> void:
	var frog = frog_scene.instance()
	frog.position = self.position
	get_tree().current_scene.add_child(frog)
	Global.crate_count -= 1
	self.queue_free()

