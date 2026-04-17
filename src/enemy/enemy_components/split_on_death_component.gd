# split_on_death_component.gd
class_name SplitOnDeathComponent
extends Node

@export var spawn_scene: PackedScene
@export var min_split: int = 3
@export var max_split: int = 5
@export var spread_distance: float = 80.0
@export var spread_speed: float = 3.0

func _ready():
	get_parent().death.connect(_on_death)

func _on_death():
	var spawn_count = (randi() % 3) + 2
	for i in spawn_count:
		var spawn = spawn_scene.instantiate()
		
		var angle = (2 * PI / spawn_count) * i
		var spread_target = get_parent().global_position + Vector2(cos(angle), sin(angle)) * spread_distance
		
		spawn.global_position = get_parent().global_position
		get_tree().current_scene.add_child(spawn)
		
		# disable movement component until spread is done
		if spawn.has_node("MovementComponent"):
			spawn.get_node("MovementComponent").enabled = false
		
		# start spreading
		spawn.set_meta("spread_target", spread_target)
		spawn.set_meta("spreading", true)
