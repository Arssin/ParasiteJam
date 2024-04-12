extends Node2D

var canInteract = false
var isSwitched = false

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



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		canInteract = false
		%Press.visible = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") && canInteract:
		if !isSwitched:
			isSwitched = true
			$AnimatedSprite2D.play("switch_to_normal")
		else:
			isSwitched = false
			$AnimatedSprite2D.play("switch_back")
