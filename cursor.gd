extends Sprite2D


var characters = []        

# Integer
var currentSelected = 0     
var currentColumnSpot = 0    
var currentRowSpot = 0      

# Exports 
@export  var player1Text : Texture    
@export  var player2Text : Texture  
@export  var amountOfRows = 2   
@export  var portraitOffset : Vector2
var posx = 0
var posy = 0

# Objects
@onready var gridContainer = get_parent().get_node("GridContainer") 



func _ready():
	if CharacterSelectionManager.player:
		CharacterSelectionManager.player.is_queued_for_deletion()
	for nameOfCharacter in get_tree().get_nodes_in_group("Characters"):
		characters.append(nameOfCharacter)

	texture = player1Text


func _process(delta):
	if(Input.is_action_just_pressed("right_1")):
		currentSelected += 1
		currentColumnSpot += 1
		if(currentColumnSpot > gridContainer.columns - 1 && currentSelected < characters.size()):
			position.x -= (currentColumnSpot - 1) * portraitOffset.x
			position.y += portraitOffset.y
			
			currentRowSpot += 1
			currentColumnSpot = 0
			
		elif(currentColumnSpot > gridContainer.columns - 1 && currentSelected > characters.size() - 1):
			position.x -= (currentColumnSpot - 1) * portraitOffset.x
			position.y -= currentRowSpot * portraitOffset.y
			
			currentColumnSpot = 0
			currentRowSpot = 0
			currentSelected = 0
		else:
			position.x += portraitOffset.x
	elif(Input.is_action_just_pressed("left_1")):
		currentSelected -= 1
		currentColumnSpot -= 1
		if(currentColumnSpot < 0 && currentSelected > 0):
			position.x += (gridContainer.columns - 1) * portraitOffset.x
			position.y -= (amountOfRows - 1) * portraitOffset.y
			
			currentColumnSpot = gridContainer.columns - 1
			currentRowSpot -= 1
		elif (currentColumnSpot < 0 && currentSelected < 0):
			position.x += (gridContainer.columns - 1) * portraitOffset.x
			position.y += (amountOfRows - 1) * portraitOffset.y
			
			currentColumnSpot = gridContainer.columns - 1
			currentRowSpot = amountOfRows - 1
			currentSelected = characters.size()
		else:
			position.x -= portraitOffset.x


	if(Input.is_action_just_pressed("ui_accept")):
		
		print(characters[currentSelected].get_name())
		if(CharacterSelectionManager.player == null):
			CharacterSelectionManager.player = CharacterSelectionManager.selectableCharacters[characters[currentSelected].get_name()]
			print(CharacterSelectionManager.player)
			texture = player2Text
		elif (CharacterSelectionManager.opponent == null):
			CharacterSelectionManager.opponent = CharacterSelectionManager.selectableCharacters[characters[currentSelected].get_name()]
			print(CharacterSelectionManager.opponent)
			get_tree().change_scene_to_file("res://level.tscn")
		elif (CharacterSelectionManager.player != null) and texture == player1Text:
			CharacterSelectionManager.player = CharacterSelectionManager.selectableCharacters[characters[currentSelected].get_name()]
			print(CharacterSelectionManager.player)
			texture = player2Text
		elif (CharacterSelectionManager.opponent != null) and texture == player2Text:
			CharacterSelectionManager.opponent = CharacterSelectionManager.selectableCharacters[characters[currentSelected].get_name()]
			print(CharacterSelectionManager.opponent)
			get_tree().change_scene_to_file("res://level.tscn")
