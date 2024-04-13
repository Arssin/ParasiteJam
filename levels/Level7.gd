extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().paused = true
	var childrens = get_tree().root.get_children()
	for child in childrens:
		if child.name == "MainScene":
			var mainScene = child.get_children()
			for scenes in mainScene:
				if scenes.name == "Win":
					scenes.visible = true
	
