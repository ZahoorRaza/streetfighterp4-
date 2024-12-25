extends raza


var root: BTNode
@export  var offsetTillFlip = 2
var moveDir
var distanceToPlayer
var direction
var chance : float = 0.0
var maxTimeTillChoice = 0.8
var countDown = maxTimeTillChoice
var aispeed = 60

var ai = get_parent()
@onready var player = CharacterSelectionManager.player1

func _ready() -> void:
	root = SelectorNode.new()

	# Attack sequence
	var attack_sequence = SequenceNode.new()
	attack_sequence.children = [
		ConditionNode.new().set_condition(is_enemy_near),
		ConditionNode.new().set_condition(is_player_not_crouched),
		ActionNode.new().set_action(attack_enemy)
	]

	
	#block reaction
	var block_reaction = SequenceNode.new()
	block_reaction.children = [
		ConditionNode.new().set_condition(is_enemy_near),
		ConditionNode.new().set_condition(is_player_blocking),
		ActionNode.new().set_action(crouch_attack)
	]

	# Defensive sequence
	var defensive_sequence = SequenceNode.new()
	defensive_sequence.children = [
		ConditionNode.new().set_condition(is_enemy_near),
		ConditionNode.new().set_condition(is_player_attacking),
		ActionNode.new().set_action(block_player)
	]
	
	
	var move_to_enemy_action = ActionNode.new()
	move_to_enemy_action.set_action(move_towards_enemy)
	
	# React to crouch sequence
	var crouch_response_sequence = SequenceNode.new()
	crouch_response_sequence.children = [
		ConditionNode.new().set_condition(is_enemy_near),
		ConditionNode.new().set_condition(is_player_crouched),
		ActionNode.new().set_action(respond_to_crouch),
		ActionNode.new().set_action(crouch_attack)
	]
	
	var crouch_response_forHK = SequenceNode.new()
	crouch_response_forHK.children = [
		ConditionNode.new().set_condition(is_enemy_near),
		ConditionNode.new().set_condition(is_player_HK),
		ActionNode.new().set_action(respond_to_crouch),
		ActionNode.new().set_action(crouch_attack)
	]
	
	
	root.children = [
					crouch_response_sequence,
					crouch_response_forHK,
					defensive_sequence,
					block_reaction,
					attack_sequence,
					move_to_enemy_action ]
	

func is_enemy_near() -> bool:
	var direction = (player.position - ai.position)
	print(direction)
	return direction >= Vector2(-65,0)

func is_player_blocking():
	chance = ReturnChance()
	if player.anim.get_current_animation() == "block" and chance < 50:
		return !player.is_player_blocking
	else:
		return player.is_player_blocking


func move_towards_enemy():
		print("Moving towards enemy...")
		ai.play_animation("forward")
		var direction = (player.position - ai.position).normalized()
		ai.position += direction * aispeed * get_process_delta_time()
		
	
	

func is_player_HK():
	if player.anim.get_current_animation() == "HK":
		return !player.is_HK
	else:
		return player.is_HK

func is_player_attacking():
	if player.anim.get_current_animation() == "LP" or player.anim.get_current_animation() =="HK" or player.anim.get_current_animation() == "LK" or player.anim.get_current_animation() =="HP":
		return !player.is_attacking
	elif player.anim.get_current_animation() != "LP" or player.anim.get_current_animation() !="HK" or player.anim.get_current_animation() != "LK" or player.anim.get_current_animation() !="HP":
		return player.is_attacking


func is_player_crouched():
	if player.anim.get_current_animation() == "crouchneutral":
		return !player.is_crouching
	elif player.anim.get_current_animation() != "crouchneutral":
		return player.is_crouching
		
		
func is_player_not_crouched():
	if player.anim.get_current_animation() == "crouchneutral":
		return player.is_crouching
	elif player.anim.get_current_animation() != "crouchneutral":
		return !player.is_crouching

func can_block() -> bool:
	return player.is_attacking

func attack_enemy():
	print("AI is attacking!")
	chance = ReturnChance()
	if chance < 50:
		ai.play_animation("LP")
	if chance > 50  and chance < 70:
		ai.play_animation("LK")
	if chance > 70  and chance < 80:
		ai.play_animation("HP")
	if chance > 80  and chance < 90:
		ai.play_animation("HK")
	countDown = maxTimeTillChoice
	
	

func block_player():
	print("AI is blocking!")
	ai.play_animation("block")

func respond_to_crouch():
	print("AI is reacting to player crouch!")
	player.is_crouching = true
	ai.play_animation("crouching")
	ai.crouch_collision.shape.extents = Vector2(ai.original_collision_size.x, ai.original_collision_size.y * 0.7)
	ai.play_animation("crouchneutral")
	player.is_crouching = false



func _process(delta: float) -> void:
	countDown -= delta
	
	if(countDown < 0):
		root.execute()
	elif(countDown > 0) and not ai.anim.is_playing():
		ai.crouch_collision.shape.extents = ai.original_collision_size
		ai.play_animation("neutral")
		

	_face_player()
	ai.move_and_slide()
	
func _face_player():
	var distanceToPlayer = player.position.x - ai.position.x 
	
	if(distanceToPlayer > offsetTillFlip):
		moveDir = 1
		ai.Sprites.scale.x = ai.Sprites.scale.y * moveDir	
	elif(distanceToPlayer < -offsetTillFlip):
		moveDir = -1
		ai.Sprites.scale.x = ai.Sprites.scale.y * moveDir
	else:
		moveDir = 0
		
func crouch_attack():
	print("AI is performing crouch attack!")
	chance = ReturnChance()
	if chance < 50:
		ai.play_animation("crouchLP")
		ai.crouch_collision.shape.extents = Vector2(ai.original_collision_size.x, ai.original_collision_size.y * 0.7)
	if chance > 50:
		ai.play_animation("crouchLK")
		ai.crouch_collision.shape.extents = Vector2(ai.original_collision_size.x, ai.original_collision_size.y * 0.7)
	countDown = maxTimeTillChoice

		


#used as a munever to make the AI perform diffrent varity of moves and add varity to moveset
func ReturnChance():
	var value = RandomNumberGenerator.new()
	value.randomize()
	return value.randi_range(0, 100)
	
	
	
