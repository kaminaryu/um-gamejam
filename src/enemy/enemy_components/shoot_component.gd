class_name ShootingComponent
extends Node2D

const ENEMY_SIZE := 48

@export var bullet_scene: PackedScene  # Drag your bullet.tscn here
@export var shoot_interval: float = 5.0
@export var bullet_speed: float = 600.0

var timer: Timer
var target: Node2D

func _ready() -> void:
	target = get_tree().get_first_node_in_group("Player")
	
	# Setup the internal timer
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = shoot_interval
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout() -> void:
	if target and is_instance_valid(target):
		shoot()

func shoot() -> void:
	if bullet_scene == null: return

	var bullet = bullet_scene.instantiate()
	
	var sprite = bullet.get_node("Sprite2D")
	# Calculate direction to player
	var direction = global_position.direction_to(target.global_position)
	
	sprite.modulate = Color("#49ab7b")
	
	var spawn_offset = direction * 50.0 
	bullet.global_position = global_position + spawn_offset
	
	get_tree().current_scene.add_child(bullet)
	
	# Point the bullet
	bullet.rotation = direction.angle()
	if "velocity" in bullet:
		bullet.velocity = direction * bullet_speed

	# THE PHYSICS FIX: Tell the bullet to ignore the enemy
	# move_and_collide will now ignore the parent enemy body
	bullet.add_collision_exception_with(get_parent())
