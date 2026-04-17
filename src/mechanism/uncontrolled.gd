extends Node2D

var init_delay: float = 0.5
var min_delay: float = 0.1
var max_delay: float = 1.0

func enable(enable: bool) -> void :
    if (enable) :
        process_mode = Node.PROCESS_MODE_ALWAYS
        $RandomDelay.start(init_delay)
    else :
        process_mode = Node.PROCESS_MODE_DISABLED
        $RandomDelay.stop()

func _on_timer_timeout() -> void:
    var random_time := randf_range(min_delay, max_delay)
    $Timer.start(random_time)
