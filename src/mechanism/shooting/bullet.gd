extends CharacterBody2D

const SPEED = 600;

func _physics_process(delta: float) -> void :
	var direction = Vector2.RIGHT.rotated(rotation)
	move_and_collide(direction * SPEED * delta)
