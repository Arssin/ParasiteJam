extends CharacterBody2D

class_name Player

var player_speed = 100
var mouse_clicked = false
var projectile := preload("res://characters/player_projectile.tscn")
var shooted_pos
var body_controlling = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.player_mind_controlling_stop.connect(_on_stop_controlling)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_clicked && !Global.player_mind_controlling:
		velocity = shooted_pos * player_speed
	
	move_and_slide()




func _input(_event: InputEvent) -> void:
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	
	if !mouse_clicked && !Global.player_mind_controlling:
		if Input.is_action_just_pressed("left_mouse"):
			var mouse_position = get_global_mouse_position()
			shooted_pos = (mouse_position - global_position).normalized()
			$PlayerCollision.disabled = true
			mouse_clicked = true

	if !mouse_clicked:
		if input_direction && !Global.player_mind_controlling:
			velocity = input_direction * player_speed
		else:
			velocity = input_direction * 0
			
		
	
func teleport(position):
	global_position = position
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		Global.player_mind_controlling = true
		mouse_clicked = false
		body.isNpcControlled = true
		body.start_mind_control()
		$".".visible = false
		
func _on_stop_controlling():
	position = Global.lastPositionRespawned
	$PlayerCollision.disabled = false
	$".".visible = true
	
