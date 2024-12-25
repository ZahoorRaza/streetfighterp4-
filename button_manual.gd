extends Control

func _process(delta: float) -> void:
	back_to_past()


func back_to_past():
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")
