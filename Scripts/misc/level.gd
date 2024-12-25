extends Node2D

class_name  raza

@onready var myopponent = CharacterSelectionManager.opponent.instantiate()
@onready  var myplayer = CharacterSelectionManager.player.instantiate()
@onready var instantiateHUD = preload("res://tscn_files/HUD.tscn").instantiate()
func _ready():
	
	SpawnChosenCharacters()

func SpawnChosenCharacters():
	CharacterSelectionManager.instantHUD = instantiateHUD
	instantiateHUD.position.x = -130
	instantiateHUD.position.y = -90
	call_deferred("add_child", instantiateHUD)
	print(myplayer)
	CharacterSelectionManager.player1 = myplayer
	CharacterSelectionManager.opponent1 = myopponent
	call_deferred("add_child", CharacterSelectionManager.player1)
	CharacterSelectionManager.player1.position.x = -190
	CharacterSelectionManager.player1.position.y = +50
	CharacterSelectionManager.player1.get_node("EmptyScript").set_script(CharacterSelectionManager.playerScript)
	
	call_deferred("add_child", CharacterSelectionManager.opponent1)
	CharacterSelectionManager.opponent1.position.x = +190
	CharacterSelectionManager.opponent1.position.y = +50
	CharacterSelectionManager.opponent1.get_node("EmptyScript").set_script(CharacterSelectionManager.aiScript)
	
	
	
	
	
	

	

	
	
