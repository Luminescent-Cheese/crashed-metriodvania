extends Node2D
#Setting up raycasts
@onready var Left = $Left
@onready var Right = $Right
@onready var Up = $Up
@onready var Down = $Down

@onready var QuadrantCollisions = {"Q1": false,"Q2": false,"Q3": true, "Q4": true}
@onready var DirectionCollisions = {"Left": null, "Right": null, "Up": null,"Down": null}

	
func _physics_process(delta: float) -> void:
	if Left.is_colliding():
		DirectionCollisions["Left"] = Left.get_collision_point()
	else:
		DirectionCollisions["Left"] = null
	if Right.is_colliding():
		DirectionCollisions["Right"] = Right.get_collision_point()
	else:
		DirectionCollisions["Right"] = null
	if Up.is_colliding():
		DirectionCollisions["Up"] = Up.get_collision_point()
	else:
		DirectionCollisions["Up"] = null
	if Down.is_colliding():
		DirectionCollisions["Down"] = Down.get_collision_point()
	else:
		DirectionCollisions["Down"] = null
	
#Handles Quadrant Collisions
#Quadrant 1
func _on_q_1_body_exited(body: Node2D) -> void:
	QuadrantCollisions["Q1"] = false

func _on_q_1_body_entered(body: Node2D) -> void:
	QuadrantCollisions["Q1"] = true
#Quadrant 2
func _on_q_2_body_exited(body: Node2D) -> void:
	QuadrantCollisions["Q2"] = false

func _on_q_2_body_entered(body: Node2D) -> void:
	QuadrantCollisions["Q2"] = true
#Quadrant 3
func _on_q_3_body_exited(body: Node2D) -> void:
	QuadrantCollisions["Q3"] = false

func _on_q_3_body_entered(body: Node2D) -> void:
	QuadrantCollisions["Q3"] = true
#Quadrant 4
func _on_q_4_body_exited(body: Node2D) -> void:
	QuadrantCollisions["Q"] = false

func _on_q_4_body_entered(body: Node2D) -> void:
	QuadrantCollisions["Q4"] = true
