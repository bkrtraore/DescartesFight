extends KinematicBody2D

var vel = Vector2()
var GRAVITY = 1000
export (int) var max_speed = 300
const UP = Vector2(0, -1)
const  ACCEL = 10

func _ready():
	pass

func setSprite(nom):
	var image = load(nom)
	$Sprite.set_texture(image)
	
func _physics_process(delta):
	
	vel.y += GRAVITY * delta
	movement_loop()
	vel = move_and_slide(vel,UP)
	
func movement_loop():	

	var left = Input.is_action_pressed("ui_q")
	var right = Input.is_action_pressed("ui_d")
	var jump = Input.is_action_pressed("ui_z")
	var sneak = Input.is_action_pressed("ui_s")
	var punch = Input.is_action_pressed("ui_a")
	var punch2 = Input.is_action_pressed("ui_e")
	var sp = Input.is_action_pressed("ui_r")
	
	var dirx = int(right) - int(left)

	if sneak == true :
		$animationJ1.play("sneak")
	elif is_on_floor()==false:
		$animationJ1.play("jump")
	elif punch == true:
		$animationJ1.play("punch")
	elif punch2 == true:
		$animationJ1.play("punch2")
	elif sp == true:
		$animationJ1.play("attacksp")
	elif dirx != 0:
		$animationJ1.play("walk")
	else :
		$animationJ1.play("idle")
	
	if dirx == -1 :
		vel.x = max(vel.x - ACCEL, -max_speed)
		$Sprite.flip_h = true #inverse les sprites
	elif dirx == 1 :
		vel.x = min(vel.x + ACCEL, +max_speed)
		$Sprite.flip_h = false
	else:
		vel.x = lerp(vel.x, 0,0.15)
	
	if jump == true and is_on_floor():
		vel.y = -700
	
