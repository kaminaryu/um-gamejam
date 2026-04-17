extends Node2D

var mechanism_controllable: Dictionary[String, Dictionary] = {
    "Shooting": {
        "enabled": true, 
        "node_path": "Attacking/ShootingMech"
    },
    "Aiming": {
        "enabled": true, 
        "node_path": "Attacking/AimingMech"
    },
    "Dash": {
        "enabled": true, 
        "node_path": "DashMech"
    },
    "Vision": {
        "enabled": true, 
        "node_path": "VisionMech"
    },
}

func _process(delta: float) -> void :
    if (Input.is_action_just_pressed("(DEBUG)ToggleShooting")) :
        toggle_mech_control("Shooting")
    if (Input.is_action_just_pressed("(DEBUG)ToggleAiming")) :
        toggle_mech_control("Aiming")
    if (Input.is_action_just_pressed("(DEBUG)ToggleDash")) :
        toggle_mech_control("Dash")
    if (Input.is_action_just_pressed("(DEBUG)ToggleVision")) :
        toggle_mech_control("Vision")
        

func toggle_mech_control(mech_name: String) -> void :
    var mechanism: Dictionary = mechanism_controllable[mech_name]
    var mechanism_node: Node = get_node(mechanism.node_path)
    mechanism_node.toggle_control()
