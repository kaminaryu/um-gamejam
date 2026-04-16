extends Node2D

const BULLET_SCENE = preload("res://src/mechanism/shooting/bullet.tscn")
const PLAYER_SIZE = 32

func enable(enable: bool) -> void :
    if (enable) :
        process_mode = Node.PROCESS_MODE_ALWAYS
        $Timer.start(0.5)
    else :
        process_mode = Node.PROCESS_MODE_DISABLED
        $Timer.stop()

func shoot() -> void :
    var bullet := BULLET_SCENE.instantiate()
    bullet.global_position = global_position
    bullet.look_at(get_global_mouse_position())
    
    # offset the bullet so it doesnt clip with the player
    bullet.global_position += Vector2.RIGHT.rotated(bullet.rotation) * PLAYER_SIZE
    
    get_tree().root.add_child(bullet)


func _on_timer_timeout() -> void:
    var random_time := randf_range(0.3, 0.67)
    $Timer.start(random_time)
    
    shoot()
