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


signal player_mind_controlling_call
signal player_mind_controlling_stop
