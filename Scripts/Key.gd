extends Area2D


func _on_Key_body_entered(body: Node) -> void:
	if body is Player:
		body.key_count += 1
		Hud.change_text("The frog has " + str(body.key_count) + " keys now.")
		self.queue_free()
