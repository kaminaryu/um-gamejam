extends ProgressBar

func _process(delta: float) -> void :
    var time_left = get_node("../DashCooldown").time_left
    value = time_left
    
    if (time_left == 0.0) :
        hide()
    else :
        show()
