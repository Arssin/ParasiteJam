extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("default")
		body.die()
	elif body is Enemy && body.isNpcControlled:
		$AnimatedSprite2D.play("default")
		var childs = get_parent().get_children()
		for ch in childs:
			if ch.name == "Player":
				ch.die()
		body.queue_free()
	else:
		$AnimatedSprite2D.play("default")
		body.marine_die()

