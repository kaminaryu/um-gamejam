extends CharacterBody2D

class_name Enemy

@export var _enemy_name: String
@export var _max_health: int
@export var _damage: int
@export var _speed: float

var current_health

func set_enemy_name(name: String):
	_enemy_name = name

func set_max_health(max_health: int):
	_max_health = max_health

func set_damage(damage: int):
	_damage = damage
	
func set_speed(speed: int):
	_speed = speed

func take_damage(dmg: int):
	current_health -= dmg
	if current_health <= 0:
		die()

func die():
	death.emit()
	queue_free()
	
signal death
