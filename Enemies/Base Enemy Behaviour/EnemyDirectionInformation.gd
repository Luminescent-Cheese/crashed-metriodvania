extends Node2D
#Setting up raycasts
@onready var Left = $Left
@onready var Right = $Right
@onready var Up = $Up
@onready var Down = $Down

@onready var DirectionCollisions = {"Left": null, "Right": null, "Up": null,"Down": null}
func _physics_process(delta: float) -> void:
	if Left.is_colliding():
		DirectionCollisions["Left"] = Left.get_collision_point()
		print(DirectionCollisions)
	if Right.is_colliding():
		DirectionCollisions["Right"] = Right.get_collision_point()
		print(DirectionCollisions)
	if Up.is_colliding():
		DirectionCollisions["Up"] = Up.get_collision_point()
		print(DirectionCollisions)
	if Down.is_colliding():
		DirectionCollisions["Down"] = Down.get_collision_point()
		print(DirectionCollisions)
	
