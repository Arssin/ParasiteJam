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


func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null


func load_level(level_name: String):
	unload_level()
	var level_path := "res://levels/%s.tscn" % level_name
	var level_resource := load(level_path)
	if (level_resource):
		level_instance = level_resource.instantiate()
		%Main.add_child(level_instance)



func _on_start_game_pressed() -> void:
	load_level("Level1")
