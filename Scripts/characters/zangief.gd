extends CharacterBody2D



## All these parameters are passed to AI script to make it aware of players moves and conditions
var is_HK = false
var is_attacking = false
var is_blocking = false
var is_crouching = false
var is_player_blocking = false
var runspeed = 80
var animation_finished = false

var frame =0
var original_collision_size

@onready var Sprites =$zangiefsprites
@onready var anim = $zangiefsprites/zangiefplayer
@onready var crouch_collision = $CollisionShape2D

func updateframe(_delta):
		frame += 1
func turn(direction):
	var dir =0
	if direction:
		dir = -1
		Sprites.scale.x = dir
	else:
		dir = 1
		Sprites.scale.x = dir

func frames():
	frame = 0
	
func play_animation(animation):
	if anim.is_playing() and anim.current_animation == animation:
		return
	anim.play(animation)
	

		
	
func _ready():
	original_collision_size = crouch_collision.shape.extents
func _physics_process(_delta):
	pass
