extends Control


@onready var hud : Control = %HUD
@onready var menu: Control = %Menu
@onready var main = %Main
@onready var camera = %Camera2D

@onready var music_off = load("res://assets/music off.png")
@onready var music_on = load("res://assets/music on.png")

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0

var isMusicOn = true

var level_instance

func _ready() -> void:
	Global.new_amound_of_shoots.connect(_change_values_shoots)
	%"Amount of shots".text = "Body control projectiles left:" + " " + str(Global.amount_of_shoots)
	
	if isMusicOn:
		%"Music Button".icon = music_on
	else:
		%"Music Button".icon = music_off


func _process(delta: float) -> void:
	if !%Menu.visible:
		%Time.visible = true
	else:
		%Time.visible = false
		
	if %Time.visible:
		time += delta
		seconds = fmod(time,60)
		minutes = fmod(time,3600) / 60
		var formatedSec = "%02d" % seconds
		%Time.text = "TIME " + str(minutes) + ":" + formatedSec
		$Win/Panel2/MarginContainer/VBoxContainer/LabelTajm.text = "YOUR TIME:" + " " + str(minutes) + ":" + formatedSec
		



func _change_values_shoots(value):
	%"Amount of shots".text = "Body control projectiles left:" + " " + str(value)


func _on_start_game_pressed() -> void:
	%Menu.visible = false
	Global.new_game()


func _input(event: InputEvent) -> void:
	if !%Menu.visible && !%Lost.visible && !$Win.visible:
		if Input.is_action_just_pressed("escape"):
			get_tree().paused = true
			%Pause.visible = true


func _on_back_to_menu_pressed() -> void:
	get_tree().paused = true
	$Win.visible = false
	%Menu.visible = true
	time = 0





func _on_music_button_pressed() -> void:
	if isMusicOn:
		isMusicOn = false
		%"Music Button".icon = music_off
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), true)
	else: 
		isMusicOn = true
		%"Music Button".icon = music_on
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), false)


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
	time = 0


func _on_resume_pressed() -> void:
	%Pause.visible = false
	get_tree().paused = false


func _on_to_menu_pressed() -> void:
	%Menu.visible = true
	time = 0
	%Pause.visible = false
	get_tree().paused = true


func _on_close_controls_pressed() -> void:
	%Infos.visible = false


func _on_button_info_pressed() -> void:
	%Infos.visible = true
