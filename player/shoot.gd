extends Node2D
@export var GunAnimationPlayer: AnimationPlayer
@export var canShoot = true
var maxAmmo = 6

var intendedDirection = 0
var currentDirection = 0
var currentAmmo = 6
func _physics_process(delta: float) -> void:
	if currentAmmo >  0:
		if Input.is_action_pressed("shoot"):
			GunAnimationPlayer.play("shoot")
	else:
		GunAnimationPlayer.play("spin")
	
	if Input.is_action_pressed("up"):
		intendedDirection = -1
	elif Input.is_action_pressed("down"):
		intendedDirection = 1
	else:
		intendedDirection = 0
	if intendedDirection != currentDirection:
		var targetAngle = (global_position.direction_to(global_position + Vector2(0, 100 * intendedDirection))).angle()
		if intendedDirection != 0:
			rotation = lerp_angle(rotation, targetAngle, 20 * delta)
		else:
			rotation = lerp_angle(rotation, 0, 20 * delta)
		if abs(currentDirection) == deg_to_rad(90) or currentDirection == 0:
			currentDirection = intendedDirection
func fireBullet():
	currentAmmo -= 1

func reload():
	currentAmmo = maxAmmo
