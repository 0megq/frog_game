extends Node2D

export var text_node_path: NodePath
onready var text_node: Label = get_node(text_node_path)

export var control_node_path: NodePath
onready var control_node: Control = get_node(control_node_path)

var can_display_text: bool = true
var text_stack: Array = []
export var text_time: float

func _ready() -> void:
	control_node.modulate = Color(255, 255, 255, 0)


func _process(delta: float) -> void:
	pass
	

func change_text(new_text: String):
	#If can_change == true, then play fade in, set can_change = false, and set text
	#If can_change == false, then add the new_text to an array stack and exit
	#Wait some time
	#If text stack is empty, then play fade out, set can_change = true
	#If text stack has items, then grab the first item and remove it from the stack, set text, set can_change = false, and repeat line 25 and down
	if can_display_text:
		$Display/AnimationPlayer.play("Fade In")
		display_text(new_text)
	elif !can_display_text:
		if text_node.text != new_text:
			text_stack.append(new_text)


func display_text(new_text: String):
	text_node.text = new_text
	can_display_text = false
	yield(get_tree().create_timer(text_time), "timeout")
	if text_stack.size() == 0:
		can_display_text = true
		$Display/AnimationPlayer.play("Fade Out")
	elif text_stack.size() > 0:
		var next_text: String = text_stack[0]
		text_stack.remove(0)
		display_text(next_text)
