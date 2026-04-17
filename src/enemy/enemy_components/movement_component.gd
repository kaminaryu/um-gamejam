class_name MovementComponent

extends Node2D

var parent: Enemy
var player: CharacterBody2D

func _ready():
	parent = get_parent()
	player = get_tree().get_first_node_in_group("Player")
	print(parent)
	print(player)
	
func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	var direction = (player.global_position - parent.global_position).normalized()
	parent.velocity = direction * parent._speed
	parent.move_and_slide()
	
