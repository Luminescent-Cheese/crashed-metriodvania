extends ColorRect
var currentState = true

func _physics_process(delta: float) -> void:
	if currentState:
		color = Color(0.266, 0.734, 0.0, 1.0)
	else:
		color = Color(0.853, 0.033, 0.0, 1.0)
