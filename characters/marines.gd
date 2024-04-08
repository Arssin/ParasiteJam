extends CharacterBody2D

class_name Enemy

var player_speed = 20

var isMindControl = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isMindControl:
		move_and_slide()


func _input(_event: InputEvent) -> void:
	if isMindControl:
		var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
		
		if input_direction:
			velocity = input_direction * player_speed
		else:
			velocity = input_direction * 0
