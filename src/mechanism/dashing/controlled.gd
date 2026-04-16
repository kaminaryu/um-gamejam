extends Node2D

var is_dashing: bool = false

func enable(enable: bool) -> void :
    if (enable) :
        process_mode = Node.PROCESS_MODE_ALWAYS
    else :
        process_mode = Node.PROCESS_MODE_DISABLED
    
func _process(delta: float) -> void :
    if (is_dashing) :
        return 
    
    if (Input.is_action_just_pressed("dash")) :
        print("is_dashing")
        is_dashing = true
        $DashDuration.start()
        
        var dash_mult: float = get_parent().get_dash_multiplier()
        apply_dash(dash_mult)


func apply_dash(multiplier: float) -> void :
    var dash_mech:    Node  = get_parent()
    var mech_handler: Node  = dash_mech.get_parent()
    var player:       Node  = mech_handler.get_parent()
    
    player.dash_mult = multiplier
    

func _on_dash_duration_timeout() -> void:
    is_dashing = false
    apply_dash(1)
