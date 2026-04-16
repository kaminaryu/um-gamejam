extends Node2D

const BULLET_SCENE = preload("res://src/mechanism/shooting/bullet.tscn")
const PLAYER_SIZE = 32

var shootingPaused = false


func enable(enable: bool) -> void :
    if (enable) :
        process_mode = Node.PROCESS_MODE_ALWAYS
    else :
        process_mode = Node.PROCESS_MODE_DISABLED
        
        
func _process(delta: float) -> void :
    if (Input.is_action_pressed("shoot")) :
        if (shootingPaused) :
            return
            
        $ShootingDelay.start()
        shootingPaused = true
            
        var bullet := BULLET_SCENE.instantiate()
        bullet.global_position = global_position
        bullet.look_at(get_global_mouse_position())
        
        # offset the bullet so it doesnt clip with the player
        bullet.global_position += Vector2.RIGHT.rotated(bullet.rotation) * PLAYER_SIZE
        
        get_tree().root.add_child(bullet)


func _on_shooting_delay_timeout() -> void:
    shootingPaused = false
