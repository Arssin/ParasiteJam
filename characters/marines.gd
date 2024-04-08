extends CharacterBody2D

class_name Enemy

var player_speed = 40


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Global.player_mind_controlling:
		move_and_slide()


func _input(_event: InputEvent) -> void:
	if Global.player_mind_controlling:
		var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
		
		if input_direction:
			velocity = input_direction * player_speed
		else:
			velocity = input_direction * 0
