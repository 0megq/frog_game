extends StaticBody2D

const frog_scene = preload("res://Scenes/PinkFrog.tscn")

onready var Main: Node2D = get_tree().current_scene


func interaction(player: Player) -> void:
	var frog = frog_scene.instance()
	frog.position = self.position
	get_tree().current_scene.add_child(frog)
	Main.crate_count -= 1
	
	Hud.change_text("\"Thank you so much for releasing me\"")
	
	self.queue_free()

