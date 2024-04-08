extends Node2D

class_name Projectile

@export var speed := 50.0

var direction := Vector2.ZERO

@onready var timer = $Timer
@onready var hitbox = $Hitbox
@onready var sprite = $Sprite2D
@onready var impact_detector = $ImpactDetector


func _ready() -> void:
	timer.start()
	look_at(position + direction)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.isMindControl = true
		queue_free()
