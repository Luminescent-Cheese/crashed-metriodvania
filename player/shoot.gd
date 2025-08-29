extends Node2D
@export var GunAnimationPlayer: AnimationPlayer
@export var canShoot = true
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		GunAnimationPlayer.play("shoot")
