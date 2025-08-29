extends CharacterBody2D
@onready var animation_tree = $PlayerAnimationTree
#Factual Variables
var MAXSPEED = 900
var gravity = 160 
var jumpHeight = 800

#For Friction the larger the number the less Friction
var groundFriction = 8
var airResistance = 30

#Changing Variables
var coyoteTime = 8
var lastHeldDirection = 0
var canJump = 0
var currentSpeed = 0
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
	elif yVelocity < 1500:
		yVelocity += gravity
	if coyoteTime > 0 and not is_on_floor():
		coyoteTime -= 1
	if Input.is_action_pressed("jump") and (is_on_floor() or coyoteTime > 0):
			yVelocity = 0
			coyoteTime = 0
			canJump = 15
			jumpHeight = 1200
	if Input.is_action_pressed("jump") and canJump > 0:
		if is_on_ceiling():
			canJump = 0
			yVelocity = 100
			jumpHeight = 0
		canJump -= 1
		jumpHeight -= jumpHeight/4
		yVelocity -= jumpHeight
	elif not Input.is_action_pressed("jump"):
		canJump = 0
	
	#Below partains to horizontal movement & friction
	if heldDirection != 0:
		if currentSpeed < MAXSPEED:
			currentSpeed += 100
	else:
		if is_on_floor():
			currentSpeed -= currentSpeed/groundFriction
			if currentSpeed < 100:
				currentSpeed = 0
		else:
			currentSpeed -= currentSpeed/airResistance 
	velocity = Vector2(lastHeldDirection * currentSpeed, yVelocity)
	move_and_slide()
	_update_animations(heldDirection, yVelocity)
	
	
func _update_animations(x,y):
	var heldDirection = x
	if y > 0:
		animation_tree["parameters/conditions/is_falling"] = true
		animation_tree["parameters/conditions/isn't_falling"] = false
	else:
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
