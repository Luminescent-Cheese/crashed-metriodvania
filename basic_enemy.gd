extends "res://Enemies/Base Enemy Behaviour/enemy_base.gd"

var SPEED = 200
func _physics_process(delta: float) -> void:
	idle_movement(SPEED)
