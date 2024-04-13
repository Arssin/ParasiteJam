extends RayCast2D


var is_casting: bool = false :
	set(value): 
		is_casting = value
		
	
		if is_casting:
			appear()
		else:
			disapear()
		set_physics_process(is_casting)

func _ready():
	is_casting = false


func _physics_process(delta: float) -> void:
	var cast_point := target_position
	force_raycast_update()
	
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		var collider = get_collider()
		
		if collider is Player:
			collider.die()
		elif collider is Enemy && collider.isNpcControlled:
			var child = get_tree().root.get_children()
			for i in child:
				if i.name == "MainScene":
					var sceneMain = i.get_children()
					for k in sceneMain:
						if k.name == "Main":
							var zet = k.get_children()
							for z in zet:
								if z.name == "Level4" or z.name == "Level5" or z.name == "Level7":
									var level = z.get_children()
									for x in level:
										if x.name == "Player":
											x.die()
			collider.queue_free()
		elif collider is Enemy:
			collider.queue_free()
		

	$Line2D.points[1] = cast_point

	

		
func appear() -> void:
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 3.0, 0.2)


func disapear() -> void:
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 0, 0.1)


func _on_timer_timeout() -> void:
	self.is_casting = true
	%Timer.stop()
	%endLaser.start()


func _on_end_laser_timeout() -> void:
	self.is_casting = false
	%endLaser.stop()
	%Timer.start()
	
