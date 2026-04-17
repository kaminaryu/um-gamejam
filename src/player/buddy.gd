extends CharacterBody2D

const BULLET_SCENE = preload("res://src/mechanism/shooting/bullet.tscn")

const ROT_SPEED := 2.0
const SPEED := 67
const BUDDY_SIZE := 24.0

var moving_direction: float
var shooting_rotation: float

func _ready() -> void :
    moving_direction = randf_range(-PI, PI)
    init_shooting()
    
    
func _process(delta: float) -> void :
    shooting_rotation += delta * ROT_SPEED
    $Sprite2D.rotation = shooting_rotation


func _physics_process(delta: float) -> void:
    velocity = Vector2.RIGHT.rotated(moving_direction) * SPEED
    var collision = move_and_collide(velocity * delta)
    
    if collision:
        var collider = collision.get_collider()
        var normal = collision.get_normal()
        
        velocity = velocity.bounce(normal)
        global_position += normal * 2.0 # Clears the hitbox


func init_shooting() -> void :
    var random_time = randf_range(1.0, 2.5)
    $ShootingDelay.start(random_time)


func _on_shooting_delay_timeout() -> void:
    # front
    var bullet := BULLET_SCENE.instantiate()
    bullet.global_position = global_position
    bullet.rotation = shooting_rotation
    bullet.scale = Vector2(0.5, 0.5)
    
    # offset the bullet so it doesnt clip with the player
    bullet.global_position += Vector2.RIGHT.rotated(shooting_rotation) * BUDDY_SIZE * 1.75
    get_tree().root.add_child(bullet)
    
    # behind
    var bullet_behind := BULLET_SCENE.instantiate()
    bullet_behind.global_position = global_position
    bullet_behind.rotation = shooting_rotation + PI
    bullet_behind.scale = Vector2(0.5, 0.5)

    # offset the bullet so it doesnt clip with the player
    bullet_behind.global_position += Vector2.RIGHT.rotated(shooting_rotation + PI) * BUDDY_SIZE * 1.75
    get_tree().root.add_child(bullet_behind)
