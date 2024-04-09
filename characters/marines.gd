extends CharacterBody2D

class_name Enemy

var player_speed = 60
var isNpcControlled = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if isNpcControlled:
		move_and_slide()


func _input(_event: InputEvent) -> void:
	if isNpcControlled:
		var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
		
		if input_direction:
			velocity = input_direction * player_speed
		else:
			velocity = input_direction * 0


func _on_mind_control_timeout() -> void:
	isNpcControlled = false
	Global.player_mind_controlling = false
	$mind_control.stop()
	
func start_mind_control() -> void:
	$mind_control.start()
