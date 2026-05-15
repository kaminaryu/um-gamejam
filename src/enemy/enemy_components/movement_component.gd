class_name MovementComponent
extends Node

@export var enabled: bool = true
@export var rebound_friction: float = 8.0 # How fast it slows down
@export var rebound_strength: float = 500.0 # High number = flies further

var parent: Enemy
var target: Node2D
var rebounding: bool = false
var rebound_velocity: Vector2 = Vector2.ZERO

func _ready():
	parent = get_parent()
	target = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	# 1. Handle Spawning Spread
	if not enabled:
		_handle_spread(delta)
		return

	# 2. Handle Rebound Logic (The Smooth Bounce)
	if rebounding:
		_handle_rebound(delta)
		return
	
	if target == null:
		return
	
	# 3. Normal Chase Logic
	var direction = (target.global_position - parent.global_position).normalized()
	parent.velocity = direction * parent._speed
	
	parent.move_and_slide()
	_check_player_collision()
	
	if (parent.global_position.distance_to(Vector2(0, 0)) > 1800) :
		parent.global_position = (parent.global_position - Vector2(0, 0)) * 0.8 

	

func _handle_rebound(delta):
	# Use your new friction variable here
	rebound_velocity = rebound_velocity.lerp(Vector2.ZERO, rebound_friction * delta)
	parent.velocity = rebound_velocity
	parent.move_and_slide()
	
	if rebound_velocity.length() < 10.0:
		rebounding = false
		parent.velocity = Vector2.ZERO

func _check_player_collision():
	for i in parent.get_slide_collision_count():
		var collision = parent.get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.is_in_group("Player"):
			# 1. The Enemy bounces itself (existing logic)
			var bounce_dir = collider.global_position.direction_to(parent.global_position)
			rebounding = true
			rebound_velocity = bounce_dir * rebound_strength * parent._speed/100
			
			# 2. THE FIX: Push the Player back too!
			# We call a function on the player to trigger their knockback
			if collider.has_method("apply_knockback"):
				collider.apply_knockback(parent.global_position)
			
			if parent.has_method("handle_hit"):
				parent.handle_hit(rebound_velocity)

func _handle_spread(delta):
	if not parent.has_meta("spreading"):
		return
	
	var spread_target = parent.get_meta("spread_target")
	parent.global_position = parent.global_position.lerp(spread_target, delta * 3.0)
	
	if parent.global_position.distance_to(spread_target) < 2.0:
		parent.remove_meta("spreading")
		parent.remove_meta("spread_target")
		enabled = true
