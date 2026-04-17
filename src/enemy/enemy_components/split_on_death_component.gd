class_name SplitOnDeathComponent
extends Node

# Changed to an Array so you can drag-and-drop multiple enemy scenes
@export var spawn_scenes: Array[PackedScene] 
@export var spread_distance: float = 80.0
@export var spread_speed: float = 3.0

func _ready():
	# Connecting to the parent's death signal
	get_parent().death.connect(_on_death)

func _on_death():
	# This picks 2, 3, or 4 (as we discussed before!)
	var spawn_count = randi_range(2, 4)
	
	for i in spawn_count:
		# 1. Pick a random scene from your array of 4 types
		var random_scene = spawn_scenes.pick_random()
		
		# 2. Instantiate that specific type
		var spawn = random_scene.instantiate()
		
		# 3. Positioning logic (Circular spread)
		var angle = (2 * PI / spawn_count) * i
		var spread_target = get_parent().global_position + Vector2(cos(angle), sin(angle)) * spread_distance
		
		spawn.global_position = get_parent().global_position
		get_tree().current_scene.add_child(spawn)
		
		# 4. Disable movement and set metadata for the spread effect
		if spawn.has_node("MovementComponent"):
			spawn.get_node("MovementComponent").enabled = false
		
		spawn.set_meta("spread_target", spread_target)
		spawn.set_meta("spreading", true)
