extends KinematicBody2D
class_name Player

#Input
var x_input: int = 0
var jump_input: int = 0
var interact_input: int = 0

#Interact
export var interact_zone_path: NodePath
onready var interact_zone: Area2D = get_node(interact_zone_path)
var key_count: int = 0

#General
var velocity: Vector2 = Vector2.ZERO

#Movement
export var move_speed: float
export var move_acc: float
export var idle_deacc: float

#Jumping
export var jump_height: float
export var jump_duration: float
export var fall_duration: float
export var max_fall: float

onready var fall_gravity: float = ((-2 * jump_height) / (fall_duration * fall_duration)) * -1
onready var jump_gravity: float =  ((-2 * jump_height) / (jump_duration * jump_duration)) *-1
onready var jump_velocity: float = ((2 * jump_height) / jump_duration) * -1

var reset_y_vel: bool = true
var can_jump: bool = true
var coyote_time_length: float = 0.15
var jump_was_pressed: bool = false
var remember_jump_length: float = 0.1


func _physics_process(delta: float) -> void:
	input()
	move(delta)
	interact()
	

func interact() -> void:
	if interact_input:
		var interactables = interact_zone.get_overlapping_bodies()
		if interactables.size() == 1:
			interactables[0].interaction(self)
		elif interactables.size() > 1:
			print("2 interactables")
		interactables = interact_zone.get_overlapping_areas()
		if interactables.size() == 1:
			interactables[0].interaction(self)
		elif interactables.size() > 1:
			print("2 interactables")


func move(delta: float) -> void:
	#Left/Right
	var h_direction: int = x_input

	velocity.x += h_direction * move_acc
	
	
	#lerps velocity.x to 0 if player is isn't holding a direction
	if !h_direction:
		velocity.x = lerp(velocity.x, 0, idle_deacc)
	
	#clamps x velocity to recoil value
	velocity.x = clamp(velocity.x, -move_speed, move_speed)
	
	#Jumping
	if is_on_floor():
		if reset_y_vel:
			velocity.y = 0.1
			reset_y_vel = false
		can_jump = true
		if jump_was_pressed:
			jump()

	if jump_input:
		jump_was_pressed = true
		remember_jump_time()
		if can_jump:
			jump()
	
	if !is_on_floor():
		reset_y_vel = true
		coyote_time()
		apply_gravity(delta)
	
	move_and_slide(velocity, Vector2.UP)


func apply_gravity(delta: float) -> void:
	var gravity: float = jump_gravity if velocity.y < 0 else fall_gravity
	if gravity:
		velocity.y += gravity * delta
	if velocity.y > max_fall:
		velocity.y = max_fall
	

func jump() -> void:
	velocity.y = jump_velocity


func coyote_time():
	yield(get_tree().create_timer(coyote_time_length), "timeout")
	can_jump = false


func remember_jump_time():
	yield(get_tree().create_timer(remember_jump_length), "timeout")
	jump_was_pressed = false


func input() -> void:
	#Resets variables
	interact_input = 0
	x_input = 0
	jump_input = 0
	
	#Horizontal
	if Input.is_action_pressed("right"):
		x_input += 1
	if Input.is_action_pressed("left"):
		x_input -= 1
	#Jump
	if Input.is_action_just_pressed("jump"):
		jump_input = 1
	#Interact
	if Input.is_action_just_released("interact"):
		interact_input = 1

func die() -> void:
	print("hi i died")


func _on_HurtBox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		die()
