# movement_component.gd
class_name MovementComponent
extends Node

@export var speed: float = 100.0
@export var enabled: bool = true

var parent: Enemy
var target: Node2D

func _ready():
	parent = get_parent()
	target = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	if not enabled:
		_handle_spread(delta)
		return
	
	if target == null:
		return
	
	var direction = (target.global_position - parent.global_position).normalized()
	parent.velocity = direction * parent._speed
	parent.move_and_slide()

func _handle_spread(delta):
	if not parent.has_meta("spreading"):
		return
	
	var spread_target = parent.get_meta("spread_target")
	
	# lerp towards spread target
	parent.global_position = parent.global_position.lerp(spread_target, delta * 3.0)
	
	# check if close enough to target
	if parent.global_position.distance_to(spread_target) < 2.0:
		parent.remove_meta("spreading")
		parent.remove_meta("spread_target")
		enabled = true  # start chasing player
