extends CharacterBody2D
@onready var directions = $Directions
#fact variables
@export var health: int = 5
@export var stunTime = .2
@export var animation:AnimatedSprite2D

#changing variables
var Enemydirection = Vector2(1,0)

var stunned = false
func take_damage(amount):
	#Takes <amount> Health away from enemy
	health -= amount
	if health > 0:
		animation.modulate = Color(1.0, 0.25, 0.25, 1.0)
		stunned = true
		await get_tree().create_timer(stunTime, true, false, true).timeout
		stunned = false
		animation.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		dead()

func idle_movement(speed):
	#basic movement for enemy
	#checks RayCasts and Quadrants for obstacles
	if Enemydirection.x == 1:
		if directions.QuadrantCollisions["Q4"] == false:
			Enemydirection.x = -1
		else:
			if directions.DirectionCollisions["Right"] != null:
				Enemydirection.x = -1

	else:
		if directions.QuadrantCollisions["Q3"] == false:
			Enemydirection.x = 1
		else:
			if directions.DirectionCollisions["Left"] != null:
				Enemydirection.x = 1
	velocity = 100 * Enemydirection
	move_and_slide()

func dead():
	queue_free()


func _on_hit_box_body_entered(body: Node2D) -> void:
	take_damage(1)
