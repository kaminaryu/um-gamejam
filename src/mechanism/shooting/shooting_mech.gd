extends Node2D

signal shot

@export var controlled: bool
func _ready() -> void :
    controlled = false
    toggle_control()
    
func toggle_control() -> void :
    controlled = !controlled
    
    if (controlled) :
        $Controlled.enable(true)
        $Uncontrolled.enable(false)
    else :
        $Controlled.enable(false)
        $Uncontrolled.enable(true)


func shoot() -> void :
    shot.emit()
    #print("Shooting")
