extends CharacterBody2D
const SPEED = 600
@export var max_bounces = 1
@export var lifetime: float = 10.0
@export var damage: int = 5
var bounces_left: int
func _ready() -> void:
    bounces_left = max_bounces
    velocity = transform.x * SPEED 
func _physics_process(delta: float) -> void:
    var collision = move_and_collide(velocity * delta)
    
    lifetime -= delta
    if lifetime <= 0:
        queue_free()
    
    if collision:
        var collider = collision.get_collider()
        var normal = collision.get_normal()
        
        # Handle Damage & Visuals
        if collider.has_node("DamageableComponent"):
            var component = collider.get_node("DamageableComponent")
            collider.take_damage(damage)
            component.handle_hit(velocity) # Visual/Nudge logicd
            
        velocity = velocity.bounce(normal)
        global_position += normal * 3.0 # Clears the hitbox
        
        $BulletBounce.play()
