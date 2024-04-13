extends CharacterBody2D

class_name Player

var player_speed = 500
var mouse_clicked = false
var projectile := preload("res://characters/player_projectile.tscn")
var shooted_pos
var body_controlling = false
@onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")
	Global.player_mind_controlling_stop.connect(_on_stop_controlling)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var position_mouse_x = get_global_mouse_position().x
	if mouse_clicked && !Global.player_mind_controlling:
		if anim.current_animation != "using":
			anim.play("fly")
		velocity = shooted_pos * 200
	
	
	if position_mouse_x < global_position.x:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
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
			if anim.current_animation != "using":
				anim.play("run")
			velocity = input_direction * player_speed
		else:
			if anim.current_animation != "using":
				anim.play("idle")
			velocity = input_direction * 0
			
		
	
func teleport(position):
	global_position = position
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy && mouse_clicked:
		Global.player_mind_controlling = true
		mouse_clicked = false
		body.isNpcControlled = true
		body.start_mind_control()
		$".".visible = false
		
func _on_stop_controlling():
	position = Global.lastPositionRespawned
	$PlayerCollision.disabled = false
	$".".visible = true
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fly":
		anim.play("idle")


func _on_levers_used_lever(_value) -> void:
	$AnimationPlayer.play("using")
	anim.play('using')
	
	
func die() -> void:
	get_tree().paused = true
	var childrens = get_tree().root.get_children()
	for child in childrens:
		if child.name == "MainScene":
			var mainScene = child.get_children()
			for scenes in mainScene:
				if scenes.name == "Lost":
					scenes.visible = true
	queue_free()
