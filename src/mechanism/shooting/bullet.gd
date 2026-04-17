extends CharacterBody2D

const SPEED = 600
@export var max_bounces = 1

var bounces_left: int

func _ready() -> void:
	bounces_left = max_bounces
	velocity = transform.x * SPEED 

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		
		print(collider)
		# Handle Damage & Visuals
		if collider.has_node("DamageableComponent"):
			var component = collider.get_node("DamageableComponent")
			collider.take_damage(5) # Assuming this is on the Enemy
			component.handle_hit(velocity) # Visual/Nudge logic
			
		# Handle Bounce
		if bounces_left > 0:
			velocity = velocity.bounce(normal)
			global_position += normal * 2.0 # Clears the hitbox
			rotation = velocity.angle()
			bounces_left -= 1
		else:
			queue_free()
