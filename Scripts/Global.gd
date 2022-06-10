extends Node

export(Array, PackedScene) var level_array

var current_level: int = 1

var crate_count: int = 0

func change_level() -> void:
	current_level += 1
	get_tree().change_scene_to(level_array[current_level-1])
