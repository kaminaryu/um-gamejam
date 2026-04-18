class_name AttackComponent
extends Node

@export var attack_cooldown: float = 1.0

var can_attack: bool = true
var parent: CharacterBody2D

func _ready():
    parent = get_parent()

func _physics_process(_delta):
    # We check collisions every frame while the enemy moves
    for i in parent.get_slide_collision_count():
        var collision = parent.get_slide_collision(i)
        var collider = collision.get_collider()
        
        if can_attack and collider.is_in_group("Player"):
            _attack(collider)

func _attack(player):
    can_attack = false
    
    # Deal the damage
    if player.has_method("take_damage"):
        player.take_damage(parent._damage)
    
    # Start cooldown timer so the player doesn't die in 1 frame
    get_tree().create_timer(attack_cooldown).timeout.connect(_on_cooldown_finished)

func _on_cooldown_finished():
    can_attack = true
