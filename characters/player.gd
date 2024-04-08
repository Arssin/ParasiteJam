extends CharacterBody2D

class_name Player

var player_speed = 100
var mouse_clicked = false
var projectile := preload("res://characters/player_projectile.tscn")
var shooted_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_clicked:
		velocity = shooted_pos * player_speed
	
	move_and_slide()




func _input(_event: InputEvent) -> void:
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	
	if !mouse_clicked:
		if Input.is_action_just_pressed("left_mouse"):
			var mouse_position = get_global_mouse_position()
			shooted_pos = (mouse_position - global_position).normalized()
			mouse_clicked = true

	if !mouse_clicked:
		if input_direction:
			velocity = input_direction * player_speed
		else:
			velocity = input_direction * 0
	
func teleport(position):
	global_position = position
	
