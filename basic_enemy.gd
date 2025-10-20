extends "res://Enemies/Base Enemy Behaviour/enemy_base.gd"
@onready var AnimationStates:AnimationTree = $AnimationTree

var SPEED = 200
func _physics_process(delta: float) -> void:
	idle_movement(SPEED)
	update_animations()
	#Animation Stuff

func update_animations():
	if velocity == Vector2(0,0):
		AnimationStates["parameters/conditions/is_moving"] = false
		AnimationStates["parameters/conditions/not_moving"] = true
	else:
		AnimationStates["parameters/conditions/is_moving"] = true
		AnimationStates["parameters/conditions/not_moving"] = false
		AnimationStates["parameters/Walk/blend_position"] = Enemydirection.x
