extends Node2D

signal fire_recoil

@export var bulletScene = preload("res://player Bullet/player_bullet.tscn")
@export var GunAnimationPlayer: AnimationPlayer

@export var canShoot = true
var maxAmmo = 0
var recoil = 1000

@onready var bulletSpawn = $ArmAnimations/bulletFirePoint
@onready var timeSinceLastBullet = $TimeSinceLastBullet

var intendedDirection: String = "not"
var currentDirection = 0
var currentAmmo = 0
var currentFacing = 1
func _physics_process(delta: float) -> void:
	
	#Gets player current position
	if Input.get_axis("left","right") != 0:
		currentFacing = int(Input.get_axis("left","right"))
	
	if get_parent().is_on_floor() and currentAmmo != maxAmmo:
		if timeSinceLastBullet.is_stopped():
			timeSinceLastBullet.start()
	else:
		timeSinceLastBullet.stop()
	#Fires gun
	if currentAmmo >  0:
		if Input.is_action_pressed("shoot"):
			timeSinceLastBullet.stop()
			GunAnimationPlayer.play("shoot")
	else:
		if get_parent().is_on_floor():
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


func _on_time_since_last_bullet_timeout() -> void:
	#if the player doesn't do anything for a while this will automatically reset their ammo
	GunAnimationPlayer.play("spin")
