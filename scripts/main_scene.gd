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
	Global.new_game()





func _on_back_to_menu_pressed() -> void:
	get_tree().paused = true
	$Win.visible = false
	%Menu.visible = true
	#get_tree().change_scene_to_file("res://scenes/main_scene.tscn")



func _on_button_pressed() -> void:
	get_tree().paused = true
	%Lost.visible = false
	%Menu.visible = true
	#get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
