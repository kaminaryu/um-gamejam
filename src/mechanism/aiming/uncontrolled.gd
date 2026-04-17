extends Node2D

const SPEED := 5.0

var new_rot: float

func enable(enable: bool) -> void :
    if (enable) :
        process_mode = Node.PROCESS_MODE_ALWAYS
        $AimingDelay.start(2.5)
    else :
        process_mode = Node.PROCESS_MODE_DISABLED
        $AimingDelay.stop()       
    
    
func _process(delta: float) -> void :
    # for larping, i mean lerping
    get_parent().rotation = lerp_angle(get_parent().rotation, new_rot, SPEED * delta)
    
    
func aim_randomly() -> void :
    print("Aiming new locationwd")
    var delta_rad = randf_range(-PI, PI)
    new_rot = get_parent().rotation + delta_rad


func _on_aiming_delay_timeout() -> void:
    aim_randomly()
    
    var new_time = randf_range(1, 5)
    $AimingDelay.start(new_time)
