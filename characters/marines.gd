extends CharacterBody2D

class_name Enemy

var enemy_speed = 60
var isNpcControlled = false
var chase_player = false
var isOnGround = false
var player = null
var isReturning = false
var positionToReturn



@export_group("Movement")
@export var move_on_path: PathFollow2D
@export var movement_speed = 0.1
@onready var pos_start = position.x

@onready var rot_start = rotation


var colorCircleClassic = Color(0.741176, 0.717647, 0.419608, 0.3)
var colorCircleAlert = Color(0.3, 0.5, 1, 0.3)


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if move_on_path && !chase_player && !isNpcControlled && !isReturning && !isOnGround:
		move_on_path.progress += movement_speed
		global_position = move_on_path.position

	if isReturning && !chase_player && !isOnGround:
		var distance_to_return = global_position.distance_to(positionToReturn)
		if distance_to_return < 1.0: 
			isReturning = false
		else:
			velocity = (positionToReturn - position).normalized() * enemy_speed
			move_and_collide(velocity * delta)

	if chase_player && !isReturning && !isOnGround:
		velocity = (player.position - position).normalized() * enemy_speed
		move_and_collide(velocity * delta)
		positionToReturn = move_on_path.position


func _input(_event: InputEvent) -> void:
	if isNpcControlled && !chase_player:
		var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
		
		if input_direction:
			velocity = input_direction * enemy_speed
		else:
			velocity = input_direction * 0


func _on_mind_control_timeout() -> void:
	isNpcControlled = false
	Global.lastPositionRespawned = position
	Global.player_mind_controlling = false
	$CollisionShape2D.disabled = true
	$mind_control.stop()
	
func start_mind_control() -> void:
	$mind_control.start()



func _draw():
	var radius = 30
	if chase_player:
		draw_circle(Vector2(0,0),radius,colorCircleAlert)
	else:
		draw_circle(Vector2(0,0),radius,colorCircleClassic)


func _on_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		chase_player = true
		queue_redraw()


func _on_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		chase_player = false
		isReturning = true
		queue_redraw()


func _on_catch_area_body_entered(body: Node2D) -> void:
	if body is Player:
		%AnimationPlayer.play("catch")
		isOnGround = true
