extends StaticBody2D

const frog_scene = preload("res://Scenes/PinkFrog.tscn")

func interaction(player: Player) -> void:
	var frog = frog_scene.instance()
	frog.position = self.position
	get_tree().root.add_child(frog)
	self.queue_free()

