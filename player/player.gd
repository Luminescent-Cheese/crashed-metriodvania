extends CharacterBody2D
@onready var Game = $".."
@onready var animation_tree = $PlayerAnimationTree

#Signals
signal ResetBulletUIBooster
#Factual Variables
var MAXSPEED = 500
var gravity = 150 
var maxjumpHeight = 600
var recoilStrength = 50
var jumpTime = 30
#controls how fast play loses speed when jumping
var jumpDivision = 6.0
#Stance is how much you can resist recoil when on the ground
var stance = 3.0
var airStance = 10.0

#For Friction the larger the number the less Friction
var groundFriction = 6
var airResistance = 30

#Changing Variables
var horizontalRecoil = 0
var jumpHeight = 0
var recoilDirection: String
var recoilTime = 0
var coyoteTime = 8
var lastHeldDirection = -1
var canJump = 0
var currentSpeed = 0.0
var yVelocity:float = 0.0


func _ready() -> void:
	animation_tree.active = true
	
func _physics_process(delta: float) -> void:
	var heldDirection = Input.get_axis("left","right")
	if heldDirection != 0:
		lastHeldDirection = Input.get_axis("left","right")
	#Gets Gravity
	if is_on_floor():
		yVelocity = 0
		coyoteTime = 8
	elif recoilTime > 0 and recoilDirection == "down":
		#Does recoil instead of gravity if pointing gun down
		yVelocity -= recoilStrength * recoilTime
		if not is_on_ceiling():
			recoilTime -= 1
		else:
			recoilTime = 0
	elif yVelocity < 1500:
		#Reduces effect of gravity when jumping
		if canJump > 0:
			yVelocity += gravity - 30
		else:
			yVelocity += gravity
		#adds recoil to gravity if pointing gun up
		if recoilTime > 0 and recoilDirection == "up":
			yVelocity += recoilStrength * recoilTime
			recoilTime -= 1
	if coyoteTime > 0 and not is_on_floor():
		coyoteTime -= 1
	#Covers Jumping
	if Input.is_action_pressed("jump") and (is_on_floor() or coyoteTime > 0):
			yVelocity = 0
			coyoteTime = 0
			canJump = jumpTime
			jumpHeight = maxjumpHeight
	if Input.is_action_pressed("jump") and canJump > 0:
		if is_on_ceiling():
			canJump = 0
			yVelocity = 100
			jumpHeight = 0
		canJump -= 1
		jumpHeight -= jumpHeight/jumpDivision
		yVelocity -= jumpHeight
	elif not Input.is_action_pressed("jump"):
		canJump = 0
	
	#Below partains to horizontal movement & friction
	# Horizontal Recoil
	var horizontalRecoilDirection = 0
	if recoilDirection == "left":
		horizontalRecoilDirection = 1
	elif recoilDirection == "right":
		horizontalRecoilDirection = -1
	if recoilTime > 0 and (recoilDirection == "right" or recoilDirection == "left"):
		horizontalRecoil += recoilStrength * recoilTime
		recoilTime -= 1
		#Friction/stance for Recoil
	if is_on_floor():
		horizontalRecoil -= (horizontalRecoil*stance)/groundFriction
	else:
		horizontalRecoil -= horizontalRecoil/airResistance
	if heldDirection != 0:
		if currentSpeed < MAXSPEED:
			currentSpeed += 45
	else:
		if is_on_floor():
			currentSpeed -= currentSpeed/groundFriction
			if currentSpeed < 100:
				currentSpeed = 0
			if horizontalRecoil < 100:
				horizontalRecoil = 0
		else:
			currentSpeed -= currentSpeed/airResistance 
	velocity = Vector2((lastHeldDirection * currentSpeed) + (horizontalRecoilDirection * horizontalRecoil), yVelocity)
	move_and_slide()
	_update_animations(heldDirection, yVelocity)
	
	

func _on_arm_fire_recoil() -> void:
	#Handles The recoil from firing
	#Direction for recoil
	if Input.is_action_pressed("up"):
		recoilDirection = "up"
	elif Input.is_action_pressed("down"):
		recoilDirection = "down"
	elif lastHeldDirection == 1:
		recoilDirection = "right"
	else:
		recoilDirection = "left"
	#Force for recoil
	if not is_on_floor() or recoilDirection == "right" or recoilDirection == "left":
		recoilTime = 8
	else:
		recoilTime = 0
	if recoilDirection == "down":
		yVelocity = 0
		if yVelocity < -200 and not is_on_floor():
			recoilTime += 1
		

func _update_animations(x,y):
	#Updates the conditions that are used by the players animation tree's state machine
	var heldDirection = x
	if y > 0:
		animation_tree["parameters/conditions/is_falling"] = true
		animation_tree["parameters/conditions/isn't_falling"] = false
		animation_tree["parameters/conditions/is_jumping"] = false
	elif y < 0:
		animation_tree["parameters/conditions/is_jumping"] = true
		animation_tree["parameters/conditions/is_falling"] = false
		animation_tree["parameters/conditions/isn't_falling"] = true
	else:
		animation_tree["parameters/conditions/is_jumping"] = false
		animation_tree["parameters/conditions/is_falling"] = false
		animation_tree["parameters/conditions/isn't_falling"] = true
		if heldDirection != 0:
			animation_tree["parameters/conditions/is_moving"] = true
			animation_tree["parameters/conditions/not_moving"] = false
		else:
			animation_tree["parameters/conditions/is_moving"] = false
			animation_tree["parameters/conditions/not_moving"] = true
	if heldDirection != 0:
		animation_tree["parameters/Idle/blend_position"] = heldDirection
		animation_tree["parameters/Walk/blend_position"] = heldDirection
		animation_tree["parameters/Falling/blend_position"] = heldDirection
		animation_tree["parameters/Jumping/blend_position"] = heldDirection


func _on_arm_reset_bullet_ui() -> void:
	ResetBulletUIBooster.emit()
