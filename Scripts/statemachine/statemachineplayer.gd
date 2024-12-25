extends statemachine


class_name getready
var isgrounded = true
var myplayer2 = get_parent()
var ground_position = 0



func _ready():
	addstate("neutral")
	addstate("forward")
	addstate("back")
	addstate("crouch")
	addstate("crouchneutral")
	addstate("crouchLK")
	addstate("crouchLP")
	addstate("LK")
	addstate("LP")
	addstate("HK")
	addstate("HP")
	addstate("block")
	addstate("jumping")
	addstate("jumpingforward")
	addstate("jumpingback")
	call_deferred("setstate",states.neutral)




func statelogic(delta):
	_physics_process(delta)
	
	
		
func gettransistion(delta):
	myplayer2.move_and_slide()
	match state:
			states.neutral:
				if !Input.is_anything_pressed():
					myplayer2.crouch_collision.shape.extents = myplayer2.original_collision_size
					myplayer2.play_animation("neutral")
					
				if Input.get_action_strength("right_1"):
					return states.forward
				if Input.get_action_strength("left_1"):
					return states.back
				if Input.is_action_pressed("LK") and not (Input.is_action_pressed("high") and Input.is_action_pressed("LK")):
					return states.LK
				if Input.is_action_pressed("LP") and not (Input.is_action_pressed("high") and Input.is_action_pressed("LP")):
					return states.LP
				if Input.is_action_pressed("high") and Input.is_action_pressed("LK"):
					return states.HK
				if Input.is_action_pressed("high") and Input.is_action_pressed("LP"):
					return states.HP
				if Input.get_action_strength("crouch"):
					return states.crouch
				#if Input.get_action_strength("jump"):
					#return states.jumping
				if Input.get_action_strength("block"):
					return states.block
					
			states.block:
				if Input.is_action_pressed("block"):
					myplayer2.play_animation("block")
				elif myplayer2.anim.is_playing():
					return
				else:
					return states.neutral
					
					
			states.forward:
				if Input.is_action_pressed("right_1"):
					myplayer2.play_animation("forward")
					myplayer2.turn(false)
					myplayer2.position += Vector2(1,0)*delta*myplayer2.runspeed
				else:
					return states.neutral
			
			states.back:
				if Input.is_action_pressed("left_1"):
					myplayer2.play_animation("forward")
					myplayer2.turn(true)
					myplayer2.position -= Vector2(1,0)*delta*myplayer2.runspeed
					
				else:
					return states.neutral
					
					
			states.LP:
				if Input.is_action_pressed("LP") and not (Input.is_action_pressed("high") and Input.is_action_pressed("LP")):
					myplayer2.play_animation("LP")
				elif myplayer2.anim.is_playing():
					return
				else:
					return states.neutral
			
			states.LK:
				if Input.is_action_pressed("LK") and not (Input.is_action_pressed("high") and Input.is_action_pressed("LK"))		:
					myplayer2.play_animation("LK")
				elif myplayer2.anim.is_playing():
					return
				else:
					return states.neutral
					
					
			states.HP:
				if Input.is_action_pressed("high") and Input.is_action_pressed("LP"):
					myplayer2.play_animation("HP")
				elif myplayer2.anim.is_playing():
					return
				else:
					return states.neutral
			
			states.HK:
				if Input.is_action_pressed("high") and Input.is_action_pressed("LK"):
					myplayer2.play_animation("HK")
				elif myplayer2.anim.is_playing():
					return
				else:
					return states.neutral
			states.crouch:
				if Input.is_action_pressed("crouch"):
					myplayer2.play_animation("crouching")
					myplayer2.crouch_collision.shape.extents = Vector2(myplayer2.original_collision_size.x, myplayer2.original_collision_size.y * 0.75)
					return states.crouchneutral
				else:
					return states.neutral
					
			states.crouchneutral:
				if Input.is_action_pressed("crouch") and not (Input.is_action_pressed("crouch") and (Input.is_action_pressed("LK") or Input.is_action_pressed("LP"))):
					myplayer2.play_animation("crouchneutral")
					myplayer2.crouch_collision.shape.extents = Vector2(myplayer2.original_collision_size.x, myplayer2.original_collision_size.y * 0.75)
					
				elif Input.is_action_pressed("crouch") and Input.is_action_pressed("LK"):
					return states.crouchLK
				elif Input.is_action_pressed("crouch") and Input.is_action_pressed("LP"):
					return states.crouchLP
				else:
					return states.neutral
			
			states.crouchLK:
				if Input.is_action_pressed("crouch") and Input.is_action_pressed("LK"):
					myplayer2.play_animation("crouchLK")
					myplayer2.crouch_collision.shape.extents = Vector2(myplayer2.original_collision_size.x, myplayer2.original_collision_size.y * 0.75)
				elif myplayer2.anim.is_playing():
					return
				else:
					return states.neutral
					
			states.crouchLP:
				if Input.is_action_pressed("crouch") and Input.is_action_pressed("LP"):
					myplayer2.play_animation("crouchLP")
					myplayer2.crouch_collision.shape.extents = Vector2(myplayer2.original_collision_size.x, myplayer2.original_collision_size.y * 0.75)
				elif myplayer2.anim.is_playing():
					return
				else:
					return states.neutral
			
			#states.jumping:
				#if isgrounded:
					#myplayer2.velocity.y = 0
					#if Input.is_action_pressed("jump"):
						#myplayer2.play_animation("jumping")
						#myplayer2.velocity.y = -200  # Set upward velocity for jumping
						#isgrounded = false
					#elif myplayer2.anim.is_playing():
						#return
				#elif not isgrounded:
					#myplayer2.velocity.y += 500 * delta  # Apply gravity
					#if Input.get_action_strength("right_1"):
						#return states.jumpingforward
					#elif Input.get_action_strength("left_1"):
						#return states.jumpingback
					#elif myplayer2.position.y >= ground_position:  # Check if landed
						#isgrounded = true
						#myplayer2.velocity.y = 0
						#return states.neutral
#
			#states.jumpingforward:
				#if not isgrounded:
					#myplayer2.play_animation("jumpforward")
					#myplayer2.velocity.y += 500 * delta  # Apply gravity
					#myplayer2.position += Vector2(1, 0) * delta * myplayer2.runspeed
					#if myplayer2.position.y >= ground_position:  # Check if landed
						#isgrounded = true
						#myplayer2.velocity.y = 0
						#return states.neutral
#
			#states.jumpingback:
				#if not isgrounded:
					#myplayer2.play_animation("jumpforward")
					#myplayer2.velocity.y += 500 * delta  # Apply gravity
					#myplayer2.position -= Vector2(1, 0) * delta * myplayer2.runspeed
					#if myplayer2.position.y >= ground_position:  # Check if landed
						#isgrounded = true
						#myplayer2.velocity.y = 0
						#return states.neutral

			
			
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				


func enterstate(newstate,oldstate):
	pass
	
func exitState(oldstate,newstate):
	pass

func statesinclude(statearray):
	for eachstate in statearray:
			if state == eachstate:
				return true
	return false
	
