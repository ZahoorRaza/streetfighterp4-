extends CharacterBody2D

var is_attacking = false
var is_blocking = false
var is_crouching = false
var is_HK = false
var is_player_blocking = false
var runspeed = 80
var animation_finished = false
var frame =0
@onready var Sprites = $spritechun_li
@onready var anim = $spritechun_li/chun_lianimationplayer
@onready var crouch_collision = $CollisionShape2D
var original_collision_size

func updateframe(delta):
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
	anim.play(animation)
	

		
	
func _ready():
	original_collision_size = crouch_collision.shape.extents
	
func _physics_process(delta):
		pass


func _on_animation_player_animation_finished(anim_name: StringName):
	pass
