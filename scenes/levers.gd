extends Node2D

var canInteract = false
var isSwitched = false
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		canInteract = true
		%Press.visible = true
		player = body



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		canInteract = false
		%Press.visible = false
		player = null


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") && canInteract && player:
		if !isSwitched:
			isSwitched = true
			emit_signal("used_lever", true)
			$AnimatedSprite2D.play("switch_to_normal")
		else:
			isSwitched = false
			emit_signal("used_lever", false)
			$AnimatedSprite2D.play("switch_back")

signal used_lever(value)
