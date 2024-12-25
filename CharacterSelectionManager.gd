extends Node2D

@export var player : PackedScene
@export var opponent : PackedScene
var playerScript = preload("res://statemachineplayer.gd")
var aiScript = preload("res://AI.gd")

@onready var player1
@onready var opponent1
@onready var instantHUD




var selectableCharacters : Dictionary = {
	"ryu" : preload("res://ryu.tscn"),
	"chun_li" : preload("res://chun_li.tscn"),
	"guile" : preload("res://guile.tscn"),
	"ken" : preload("res://ken.tscn"),
	"blanka": preload("res://blanka.tscn"),
	"zangief": preload("res://zangief.tscn")
}
