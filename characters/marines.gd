extends CharacterBody2D

class_name Enemy

var player_speed = 60
var isNpcControlled = false


@export var vision_renderer: Polygon2D
@export var alert_color: Color

@export_group("Rotation")
@export var is_rotating = false
@export var rotation_speed = 0.1
@export var rotation_angle = 90

@export_group("Movement")
@export var move_on_path: PathFollow2D
@export var movement_speed = 0.1
@onready var pos_start = position.x

@onready var original_color = vision_renderer.color if vision_renderer else Color.WHITE
@onready var rot_start = rotation

#func _on_vision_cone_area_body_entered(body: Node2D) -> void:
	## print("%s is seeing %s" % [self, body])
	#vision_renderer.color = alert_color
#
#func _on_vision_cone_area_body_exited(body: Node2D) -> void:
	## print("%s stopped seeing %s" % [self, body])
	#vision_renderer.color = original_color




func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if isNpcControlled:
		move_and_slide()


func _physics_process(delta: float) -> void:
	if is_rotating:
		rotation = rot_start + sin(Time.get_ticks_msec()/1000. * rotation_speed) * deg_to_rad(rotation_angle/2.)
	if move_on_path:
		move_on_path.progress += movement_speed
		global_position = move_on_path.position
		rotation = move_on_path.rotation


func _input(_event: InputEvent) -> void:
	if isNpcControlled:
		var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
		
		if input_direction:
			velocity = input_direction * player_speed
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
