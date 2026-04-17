extends Node2D

var mechanism_controllable: Dictionary[String, bool] = {
    "Shooting": true,
    "Dashing" : true,
}

func _process(delta: float) -> void :
    if (Input.is_action_just_pressed("(DEBUG)ToggleDash")) :
        $DashMech.toggle_control()
    if (Input.is_action_just_pressed("(DEBUG)ToggleShooting")) :
        $ShootingMech.toggle_control()
