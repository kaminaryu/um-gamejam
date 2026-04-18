class_name DamageableComponent
extends Node2D

@export var nudge_distance: float = 45.0
var parent: CharacterBody2D

func _ready():
    parent = get_parent()

func handle_hit(incoming_velocity: Vector2):
    var knockback_dir = incoming_velocity.normalized()
    var target_pos = parent.global_position + (knockback_dir * nudge_distance)
    
    # 1. Create the Tween
    var tween = create_tween()
    
    # 2. Smoothly move the position
    # TRANS_QUART and EASE_OUT make it start fast and slotw down gently
    tween.tween_property(parent, "global_position", target_pos, 0.15)\
        .set_trans(Tween.TRANS_QUART)\
        .set_ease(Tween.EASE_OUT)
    
    # 3. Add the Smooth Highlight (Flash and Fade)
    parent.get_node("Sprite2D").modulate = Color(10, 10, 10) # Bright flash
    tween.parallel().tween_property(parent.get_node("Sprite2D"), "modulate", Color.WHITE, 0.2)
    
    
