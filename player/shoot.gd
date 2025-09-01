extends Node2D

signal fire_recoil

@export var bulletScene = preload("res://player Bullet/player_bullet.tscn")
@export var GunAnimationPlayer: AnimationPlayer

@export var canShoot = true
var maxAmmo = 6
var recoil = 1000

@onready var bulletSpawn = $ArmAnimations/bulletFirePoint
var intendedDirection: String = "not"
var currentDirection = 0
var currentAmmo = 6
var currentFacing = 1
func _physics_process(delta: float) -> void:
	
	#Gets player current position
	if Input.get_axis("left","right") != 0:
		currentFacing = int(Input.get_axis("left","right"))
		
	#Fires gun
	if currentAmmo >  0:
		if Input.is_action_pressed("shoot"):
			GunAnimationPlayer.play("shoot")
	else:
		GunAnimationPlayer.play("spin")
		
	#rotates gun to right position (intendedDirection is used to tell the bullets which direction to fire)
	if Input.is_action_pressed("up"):
		currentDirection = lerp_angle(currentDirection, 80, 20 * delta)
		intendedDirection = "up"
	elif Input.is_action_pressed("down"):
		currentDirection = lerp_angle(currentDirection, -80, 20 * delta)
		intendedDirection = "down"
	else:
		currentDirection = lerp_angle(currentDirection, 0, 20 * delta)
		intendedDirection = "not"
	rotation = currentDirection	* currentFacing
	
func fireBullet():
	currentAmmo -= 1
	var newBullet = bulletScene.instantiate()
	newBullet.global_position = bulletSpawn.global_position
	if intendedDirection == "up":
		newBullet.direction = Vector2(0,-1)
	elif intendedDirection == "down":
		newBullet.direction = Vector2(0,1)
	else:
		newBullet.direction = Vector2(currentFacing, 0)
	newBullet.additionVelocity = get_parent().velocity
	get_parent().add_sibling(newBullet)
	fire_recoil.emit()

func reload():
	currentAmmo = maxAmmo
