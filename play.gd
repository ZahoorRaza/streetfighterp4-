extends Button
#160,103,186 => purple
#230,53,38 => red
func on_focus_entered():
	add_theme_color_override("font_color" ,Color(160,103,186))

func on_focus_exit():
	add_theme_color_override("font_color" ,Color(230,53,38))
	
func on_pressed():
	get_tree().change_scene_to_file("res://characterselection.tscn")
	
func on_area2d_entered(area):
	emit_signal("focus_entered")

func on_area2d_exit(area):
	emit_signal("focus_exited")
