extends Node

export(Array, PackedScene) var level_array

var current_level: int = 1


func change_level() -> void:
	current_level += 1
	print(current_level)
	get_tree().change_scene(level_array[current_level-1])
