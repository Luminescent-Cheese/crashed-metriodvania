extends CharacterBody2D
#fact variables
@export var health: int = 5
@export var stunTime = .2
@export var animation:AnimatedSprite2D

#changing variables
var stunned = false
func take_damage(amount):
	health -= amount
	animation.modulate = Color(1.0, 0.25, 0.25, 1.0)
	stunned = true
	await get_tree().create_timer(stunTime, true, false, true).timeout
	stunned = false
	animation.modulate = Color(1.0, 1.0, 1.0, 1.0)
