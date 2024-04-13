extends Node

@export var player_mind_controlling = false:
	get:
		return player_mind_controlling
	set(value):
		if value:
			emit_signal("player_mind_controlling_call")
		else:
			emit_signal("player_mind_controlling_stop")
		
		player_mind_controlling = value
		
		
var lastPositionRespawned = null

var level_instance

func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null

func load_level(level_name: String):
	unload_level()
	var level_path := "res://levels/%s.tscn" % level_name
	var level_resource := load(level_path)
	print(level_resource, level_path)
	if (level_resource):
		var childrens = get_tree().root.get_children()
		for child in childrens:
			if child.name == "MainScene":
				var main = child.get_child(2)
				level_instance = level_resource.instantiate()
				main.add_child(level_instance)


signal player_mind_controlling_call
signal player_mind_controlling_stop
