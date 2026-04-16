extends CharacterBody2D

const SPEED := 200
const DASH_MULTIPLIER := 3

var dash_mult := 1.0


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
