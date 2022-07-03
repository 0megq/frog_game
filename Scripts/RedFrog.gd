extends KinematicBody2D

export(Array, NodePath) var points_path
onready var points = []
var current_point: int = 0

var velocity: Vector2 = Vector2.ZERO

export var move_speed: float
export var stop_length: float

var direction: Vector2 = Vector2.ZERO
var can_move: bool = true


func _ready() -> void:
	for _point in points_path:
		points.append(get_node(_point).position)
	self.position = points[0]


func _physics_process(delta: float) -> void:
	if self.position.distance_to(points[current_point]) < move_speed/120:
		self.position = points[current_point]
		current_point += 1
		if current_point > points.size() - 1:
			current_point = 0
		
		var angle: float = get_angle_to(points[current_point])
		
		direction = Vector2(cos(angle), sin(angle))
		
		can_move = false
		yield(get_tree().create_timer(stop_length), "timeout")
		can_move = true
	elif can_move:
		move(delta)
		
		
func move(delta: float) -> void:
	velocity.x = move_speed * direction.x
	velocity.y = move_speed * direction.y
	
	move_and_slide(velocity, Vector2.UP)

