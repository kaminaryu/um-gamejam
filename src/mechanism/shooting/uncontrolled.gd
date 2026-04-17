extends Node2D

func enable(enable: bool) -> void :
    if (enable) :
        process_mode = Node.PROCESS_MODE_ALWAYS
        $Timer.start(0.5)
    else :
        process_mode = Node.PROCESS_MODE_DISABLED
        $Timer.stop()
        

func _on_timer_timeout() -> void:
    var random_time := randf_range(0.3, 0.67)
    $Timer.start(random_time)
    
    get_parent().shoot()
