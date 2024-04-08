extends CharacterBody2D

class_name Player

var player_speed = 100

var projectile := preload("res://characters/player_projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var position_mouse_x = get_global_mouse_position().x
	
	if Input.is_action_just_pressed("left_mouse"):
		shoot()
	
	move_and_slide()

func shoot():
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	velocity = direction * player_speed

	#while true:
		#var move_and_collide_result = move_and_collide(velocity)
		#if move_and_collide_result:
			#if move_and_collide_result.collider:
				#break
	#var bullet = projectile.instantiate()
	#bullet.position = $".".global_position
	#bullet.direction = global_position.direction_to(get_global_mouse_position())
	#add_child(bullet)

func _input(_event: InputEvent) -> void:
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	
	if input_direction:
		velocity = input_direction * player_speed
	else:
		velocity = input_direction * 0
	
func teleport(position):
	global_position = position
	
