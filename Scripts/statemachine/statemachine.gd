extends Node2D

class_name statemachine
var maxTimeTillChoice = 3
var countDown = maxTimeTillChoice

func _physics_process(delta):
		if state != null:
			var transition = gettransistion(delta)
			if transition != null:
				setstate(transition)
		


var state = null
var previousstate = null
var states = {}





func statelogic(delta):
	pass
	
func gettransistion(delta):
	return null
	
func enterstate(newstate, oldstate):
		pass

func exitstate( oldstate,newstate):
		pass

func setstate(newstate):
	previousstate = state
	state = newstate
	
	if previousstate != null:
		exitstate(previousstate,newstate)
	if newstate != null:
		enterstate(newstate,previousstate)
		
func addstate(statename):
	states[statename] = states.size()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countDown-=delta
	if countDown <= 0:
		_physics_process(delta)
	elif countDown > 0:
		countDown = maxTimeTillChoice
