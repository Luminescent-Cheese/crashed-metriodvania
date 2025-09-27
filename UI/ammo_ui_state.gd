extends Sprite2D
var currentState:bool = true

func _physics_process(delta: float) -> void:
	if currentState:
		visible = true
	else:
		visible = false
