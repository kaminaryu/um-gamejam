extends CharacterBody2D

class_name Enemy

@export var _enemy_name: String
@export var _health: int
@export var _damage: int
@export var _speed: float

func _ready() -> void:
	WaveHandler.register_enemy()

func set_enemy_name(name: String):
	_enemy_name = name

func set_max_health(health: int):
	_health = health
	
func set_damage(damage: int):
	_damage = damage
	
func set_speed(speed: int):
	_speed = speed

func take_damage(dmg: int):
	_health -= dmg
	if _health <= 0:
		die()

func die():
	WaveHandler.enemy_defeated()
	death.emit()
	queue_free()
	
signal death
