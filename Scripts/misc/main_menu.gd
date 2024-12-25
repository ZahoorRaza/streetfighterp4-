extends Control

var currentstate = States.exit
@onready var selector = $pointer


enum States{
	play,
	manual,
	exit
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var pos = selector.get_overlapping_areas()
		for button in pos:
			if button.get_parent().get_name() == "play":
				button.get_parent().emit_signal("pressed")
			elif button.get_parent().get_name() == "manual":
				button.get_parent().emit_signal("pressed")
			elif button.get_parent().get_name() == "exit":
				button.get_parent().emit_signal("pressed")
				
	match currentstate:
		States.play:
			play()
			if Input.is_action_just_pressed("up"):
				currentstate = States.exit 
			if Input.is_action_just_pressed("down"):
				currentstate = States.manual 
			
			
		States.manual:
			manual()
			if Input.is_action_just_pressed("up"):
				currentstate = States.play 
			if Input.is_action_just_pressed("down"):
				currentstate = States.exit 
				
		States.exit:
			exit()
			if Input.is_action_just_pressed("up"):	
				currentstate = States.manual 
			if Input.is_action_just_pressed("down"):
				currentstate = States.play 
			
			
func play():
	selector.global_position = Vector2(242,355)
func manual():
	selector.global_position = Vector2(242,471)
func exit():
	selector.global_position = Vector2(242,527)
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
	
