class_name DamageableComponent
extends Node2D

var parent: Enemy

func _ready():
	parent = get_parent()
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Bullet")):
		parent.take_damage(5)
