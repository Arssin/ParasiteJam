extends Control


@onready var hud : Control = %HUD
@onready var menu: Control = %Menu
@onready var main = %Main
@onready var camera = %Camera2D

@onready var music_off = load("res://assets/music off.png")
@onready var music_on = load("res://assets/music on.png")

var isMusicOn = true

var level_instance

func _ready() -> void:
	Global.new_amound_of_shoots.connect(_change_values_shoots)
	%"Amount of shots".text = str(Global.amount_of_shoots)
	
	if isMusicOn:
		%"Music Button".icon = music_on
	else:
		%"Music Button".icon = music_off

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _change_values_shoots(value):
	print('lets go')
	%"Amount of shots".text = str(value)


func _on_start_game_pressed() -> void:
	%Menu.visible = false
	Global.new_game()





func _on_back_to_menu_pressed() -> void:
	get_tree().paused = true
	$Win.visible = false
	%Menu.visible = true
	#get_tree().change_scene_to_file("res://scenes/main_scene.tscn")





func _on_music_button_pressed() -> void:
	if isMusicOn:
		isMusicOn = false
		%"Music Button".icon = music_off
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
	else: 
		isMusicOn = true
		%"Music Button".icon = music_on
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), false)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_btn_creds_pressed() -> void:
	%Creds.visible = false


func _on_credits_pressed() -> void:
	%Creds.visible = true


func _on_btn_label_pressed() -> void:
	get_tree().paused = true
	%Lost.visible = false
	%Menu.visible = true
