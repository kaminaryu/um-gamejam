extends CharacterBody2D

const MAX_HEALTH := 100
const SPEED := 200
const DASH_MULTIPLIER := 3

var dash_mult := 1.0
var current_health: int

func _ready():
	current_health = MAX_HEALTH
	
func _physics_process(delta: float) -> void :
	handle_movement(delta)

	
func handle_movement(delta: float) -> void :
	var direction := Vector2.ZERO;
	
	if (Input.is_action_pressed("move_up")) :
		direction.y += -1
	if (Input.is_action_pressed("move_left")) :
		direction.x += -1
	if (Input.is_action_pressed("move_down")) :
		direction.y += 1
	if (Input.is_action_pressed("move_right")) :
		direction.x += 1
	
	velocity = direction.normalized() * SPEED * dash_mult 
	move_and_slide()

func take_damage(dmg: int):
	current_health -= dmg
	if current_health <= 0:
		die()

func die():
	death.emit()
	queue_free()
	
signal death
