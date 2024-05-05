extends RayCast2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	

