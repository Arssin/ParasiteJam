extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
	elif body is Enemy && body.isNpcControlled:
		$Player.die()
		body.queue_free()
	else:
		body.queue_free()


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.load_level("Level4")
