extends Area2D


func _on_Key_body_entered(body: Node) -> void:
	if body is Player:
		body.key_count += 1
		self.queue_free()
