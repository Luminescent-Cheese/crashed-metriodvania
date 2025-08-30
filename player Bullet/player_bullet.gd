extends CharacterBody2D

@export var direction: Vector2
@export var bulletSpeed: int = 3000
@export var additionVelocity: Vector2

func _physics_process(delta: float) -> void:
	velocity = additionVelocity + (direction * bulletSpeed)
	move_and_slide()


func _on_bullet_auto_delete_timeout() -> void:
	queue_free()
