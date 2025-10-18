extends "res://Enemies/Base Enemy Behaviour/enemy_base.gd"
var Enemydirection = Vector2(1,0)

func _physics_process(delta: float) -> void:
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
	
