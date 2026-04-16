extends Node2D

@export var controlled: bool
const _DASH_MULTIPLIER := 3

func _ready() -> void :
    controlled = false
    toggle_control()
    
func toggle_control() -> void :
    controlled = !controlled
    
    if (controlled) :
        $Controlled.enable(true)
        $Uncontrolled.enable(false)
        print("Dashing Is Controlleable")
    else :
        $Controlled.enable(false)
        $Uncontrolled.enable(true)
        print("Dashing Is Uncontrolleable")

func get_dash_multiplier() -> float :
    return _DASH_MULTIPLIER
