extends Node2D
@export var GunAnimationPlayer: AnimationPlayer
@export var canShoot = true
var maxAmmo = 6

var intendedDirection: String = "not"
var currentDirection = 0
var currentAmmo = 6
var currentFacing = 1
func _physics_process(delta: float) -> void:
	if Input.get_axis("left","right") != 0:
		currentFacing = int(Input.get_axis("left","right"))
	if currentAmmo >  0:
		if Input.is_action_pressed("shoot"):
			GunAnimationPlayer.play("shoot")
	else:
		GunAnimationPlayer.play("spin")
	if Input.is_action_pressed("up"):
		currentDirection = lerp_angle(currentDirection, 80, 20 * delta)
	elif Input.is_action_pressed("down"):
		currentDirection = lerp_angle(currentDirection, -80, 20 * delta)
	else:
		currentDirection = lerp_angle(currentDirection, 0, 20 * delta)
	rotation = currentDirection	* currentFacing
func fireBullet():
	currentAmmo -= 1

func reload():
	currentAmmo = maxAmmo
