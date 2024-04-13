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
	
	#collision_particles_2.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		var collider = get_collider()
		
		if collider is Player:
			collider.die()
		
		if collider is Enemy:
			print('essa')
			collider.queue_free()
		
		#collision_particles_2.global_rotation = get_collision_normal().angle()
		#collision_particles_2.position = cast_point
	
	$Line2D.points[1] = cast_point
	#beam_particle_2d.position = cast_point * 0.5
	#beam_particle_2d.process_material.emission_box_extents.x = cast_point.length() * 0.5
	

		
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
	
