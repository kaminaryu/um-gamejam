extends Node2D

var is_dashing: bool = false
var able_to_dash: bool = true


func enable(enable: bool) -> void :
    if (enable) :
        process_mode = Node.PROCESS_MODE_ALWAYS
    else :
        process_mode = Node.PROCESS_MODE_DISABLED
    
    
func _process(delta: float) -> void :
    if (is_dashing or not able_to_dash) :
        return 
    
    if (Input.is_action_just_pressed("dash")) :
        print("is_dashing")
        is_dashing = true
        $DashDuration.start()
        
        var dash_mult: float = get_parent().get_dash_multiplier()
        apply_dash(dash_mult)
        
        get_parent().after_image(true)
        
        $DashCooldown.start()
        able_to_dash = false


func apply_dash(multiplier: float) -> void :
    var dash_mech:    Node  = get_parent()
    var mech_handler: Node  = dash_mech.get_parent()
    var player:       Node  = mech_handler.get_parent()
    
    player.dash_mult = multiplier
    

func _on_dash_duration_timeout() -> void:
    is_dashing = false
    apply_dash(1)
    get_parent().after_image(false)


func _on_dash_cooldown_timeout() -> void:
    able_to_dash = true
