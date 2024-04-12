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
var isPatrolling = true
var previous_global_position = Vector2.ZERO

@onready var anim = %AnimationPlayer

func _ready() -> void:
	anim.play("idle")
	previous_global_position = global_position


func _process(delta: float) -> void:
	if chase_player && !isReturning && !isOnGround && !isPatrolling && player:
		%AnimationPlayer.play("run")
		print(player.global_position.x > global_position.x)
		if player.global_position.x > global_position.x:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
		velocity = (player.position - position).normalized() * enemy_speed
		move_and_collide(velocity * delta)
		positionToReturn = move_on_path.position


func _physics_process(delta: float) -> void:


	
	if isPatrolling && move_on_path && !chase_player && !isNpcControlled && !isReturning && !isOnGround:
		%AnimationPlayer.play("run")
		move_on_path.progress += movement_speed
		global_position = move_on_path.position
		
		var current_global_position = global_position
		
		if current_global_position.x > previous_global_position.x:
			scale.x = 1.6
		elif current_global_position.x < previous_global_position.x:
			scale.x = -1.6
		else:
			pass
		
		previous_global_position = current_global_position

	if isReturning && !chase_player && !isOnGround && !isPatrolling:
		%AnimationPlayer.play("run")
		var distance_to_return = global_position.distance_to(positionToReturn)
		if distance_to_return < 1.0: 
			isReturning = false
			isPatrolling = true
		elif isReturning && !isPatrolling && !chase_player:
			velocity = (positionToReturn - position).normalized() * enemy_speed
			move_and_collide(velocity * delta)
		
		var current_global_position = global_position
		
		if current_global_position.x > previous_global_position.x:
			scale.x = 1.6
		elif current_global_position.x < previous_global_position.x:
			scale.x = -1.6
		else:
			pass
		
		previous_global_position = current_global_position


			
		
		
	if !chase_player && !isReturning && !isOnGround && !isPatrolling:
		%AnimationPlayer.play("idle")
		



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
	var radius = 43
	if chase_player:
		draw_circle(Vector2(0,0),radius,colorCircleAlert)
	else:
		draw_circle(Vector2(0,0),radius,colorCircleClassic)


func _on_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		chase_player = true
		isReturning = false
		isPatrolling = false
		queue_redraw()


func _on_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		isReturning = true
		chase_player = false
		queue_redraw()


func _on_catch_area_body_entered(body: Node2D) -> void:
	if body is Player:
		%AnimationPlayer.play("catch")
		isOnGround = true


func _on_hit_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.queue_free()


func _on_stand_up_timeout() -> void:
	%AnimationPlayer.play("stand_up")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "catch":
		%stand_up.start()
	elif anim_name == "stand_up":
		isOnGround = false


func _on_animation_player_current_animation_changed(name: String) -> void:
	pass # Replace with function body.


func _on_animation_player_animation_changed(old_name: StringName, new_name: StringName) -> void:
	pass # Replace with function body.
