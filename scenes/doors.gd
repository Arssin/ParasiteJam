extends StaticBody2D

@onready var anim = $sprite
@onready var collision = $collision

func _ready() -> void:
	collision.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

