extends CharacterBody2D

signal health_changed(new_value)

const MAX_HEALTH := 100
const SPEED := 200
const DASH_MULTIPLIER := 3

@export var rebound_strength: float = 1000.0
@export var rebound_friction: float = 10.0

var dash_mult := 1.0
var current_health: int
var knockback_velocity: Vector2 = Vector2.ZERO
var _is_invincible := false


func _ready():
	current_health = MAX_HEALTH
	
	$IFrames.finished_iframe.connect(_on_finished_iframe)


func _physics_process(delta: float) -> void:
	# 1. Bleed off knockback velocity every frame
	knockback_velocity = knockback_velocity.lerp(Vector2.ZERO, rebound_friction * delta)
	handle_movement(delta)
	
	if (global_position.distance_to(Vector2(0, 0)) > 1900) :
		global_position = (global_position - Vector2(0, 0)) * 0.8 

func handle_movement(delta: float) -> void:
	var direction := Vector2.ZERO
	
	if (Input.is_action_pressed("move_up")):
		direction.y += -1
	if (Input.is_action_pressed("move_left")):
		direction.x += -1
	if (Input.is_action_pressed("move_down")):
		direction.y += 1
	if (Input.is_action_pressed("move_right")):
		direction.x += 1
	
	# 2. Combine normal movement with knockback
	var move_velocity = direction.normalized() * SPEED * dash_mult
	velocity = move_velocity + knockback_velocity
	
	move_and_slide()
	
	# 3. Check if we bumped into an enemy
	_check_rebound()


func _check_rebound():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Make sure your enemies are in a group called "enemies"
		if collider.is_in_group("Enemy"):
			# Calculate direction AWAY from the enemy
			var bounce_dir = collider.global_position.direction_to(global_position)
			
			# Apply the knockback force
			knockback_velocity = bounce_dir * rebound_strength
			
			# Optional: nudge position to prevent "sticking"
			global_position += bounce_dir * 3.0

# Inside your Player script

func apply_knockback(from_position: Vector2) -> void:
	if (_is_invincible) :
		return
		
	# Calculate direction from the enemy to the player
	var push_dir = from_position.direction_to(global_position)
	
	# Set the knockback_velocity (the variable used in your handle_movement)
	knockback_velocity = push_dir * rebound_strength
	

func take_damage(dmg: int):
	if (_is_invincible) :
		return


	$IFrames.apply_iframe()
	$PassiveHealing.stop_healing()
	_is_invincible = true

	current_health -= dmg
	health_changed.emit(current_health)
	print("taking damage: ", current_health)

	var sprite = $Sprite2D
	var tween = create_tween()

	sprite.modulate = Color(10,10,10)

	tween.tween_property(sprite, "modulate", Color.WHITE, 0.2)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

	$PlayerHurt.pitch_scale = randf_range(0.9, 1.1)
	$PlayerHurt.play()

	if current_health <= 0:
		GameMaster.player_death()


func die():
	death.emit()
	queue_free()
	
	
func heal() -> void :
	var delta_health = randi_range(3, 5)
	current_health += delta_health
	current_health = min(current_health, MAX_HEALTH)
	print("Healing (", delta_health, "): ", current_health)
	health_changed.emit(current_health)
	

func _on_finished_iframe() -> void :
	_is_invincible = false
	$PassiveHealing.init_healing()


signal death
