extends Control


@onready var hud : Control = %HUD
@onready var menu: Control = %Menu
@onready var main = %Main
@onready var camera = %Camera2D

var level_instance

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_game_pressed() -> void:
	%Menu.visible = false
	Global.load_level("Level1")


func _on_label_3_pressed() -> void:
	%Menu.visible = true
	$Win.visible = false
