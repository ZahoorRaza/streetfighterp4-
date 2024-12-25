extends Node2D

@export var player : PackedScene
@export var opponent : PackedScene
var playerScript = preload("res://Scripts/statemachine/statemachineplayer.gd")
var aiScript = preload("res://Scripts/AI/AI.gd")#don't worry if theses an error here the game will work

@onready var player1
@onready var opponent1
@onready var instantHUD




var selectableCharacters : Dictionary = {
	"ryu" : preload("res://tscn_files/ryu.tscn"),
	"chun_li" : preload("res://tscn_files/chun_li.tscn"),
	"guile" : preload("res://tscn_files/guile.tscn"),
	"ken" : preload("res://tscn_files/ken.tscn"),
	"blanka": preload("res://tscn_files/blanka.tscn"),
	"zangief": preload("res://tscn_files/zangief.tscn")
}
