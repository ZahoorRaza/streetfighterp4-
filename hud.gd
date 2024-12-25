extends Control


@onready var player1HealthBar =  get_node("KO_bar/PlayerHealth")
@onready var AIHealthBar = get_node("KO_bar/AIHealth")

@onready var myHUD = preload("res://HUD.tscn")

@onready var instantHUDFinal


var oneSeconds = 9
var tenSeconds = 9 
var resetOnes = true
var fromPlayerHealth
var damage

@onready var timer = get_node("Timer/Timeuntil")
@onready var oneSprite = get_node("Timer/1s")
@onready var tenSprite = get_node("Timer/10s")

@export var timeSprites :Array  

@export  var namesP1 :Array 
@export  var namesP2 :Array  

@onready var playerName1 = get_node("Names/Player Name 1")
@onready var playerName2 = get_node("Names/Player Name 2")

func _ready():
	player1HealthBar.value = player1HealthBar.max_value
	AIHealthBar.value = AIHealthBar.max_value

func UpdateHealth(fromPlayerHealth,damage):
	if(fromPlayerHealth):
		player1HealthBar.value  -= damage
		player1HealthBar.queue_redraw()
		if(player1HealthBar.value  <= 0):
			GameOver()
	else:
		AIHealthBar.value  -= damage
		AIHealthBar.queue_redraw()
		if(AIHealthBar.value  <= 0):
			GameOver()

#func UpdateNameElements(var player1ID, var player2ID):
	#playerName1.texture = namesP1[player1ID]
	#playerName2.texture = namesP2[player2ID]

func GameOver():
	CharacterSelectionManager.player1.set_process(false)
	CharacterSelectionManager.opponent1.set_process(false)
	if(AIHealthBar.value  <= 0):
		CharacterSelectionManager.opponent1.play_animation("down")
		CharacterSelectionManager.player1.play_animation("victorypose")
	if(player1HealthBar.value  <= 0):
		CharacterSelectionManager.player1.play_animation("down")
		CharacterSelectionManager.opponent1.play_animation("victorypose")


func _on_timer_timeout() -> void:
	oneSprite.texture = timeSprites[oneSeconds]
	tenSprite.texture = timeSprites[tenSeconds]
	oneSeconds -= 1
	
	if(oneSeconds < 0):
		if(resetOnes):
			oneSeconds = 9
			tenSeconds -= 1
		else:
			oneSeconds = 0
			timer.stop()
			GameOver()
		
		if(tenSeconds == 0):
			tenSeconds = 0
			resetOnes = false


	
	
	
func _process(delta: float) -> void:
	if Engine.get_process_frames() % 100 == 0:
		_on_timer_timeout()
	if(AIHealthBar.value  <= 0):
		GameOver()
	if(player1HealthBar.value  <= 0):
		GameOver()
		
	if Engine.get_process_frames() % 500 == 0 and ((AIHealthBar.value  <= 0) or (player1HealthBar.value  <= 0)) :
		CharacterSelectionManager.player1.queue_free()
		CharacterSelectionManager.opponent1.queue_free()
		get_tree().change_scene_to_file("res://characterselection.tscn")
