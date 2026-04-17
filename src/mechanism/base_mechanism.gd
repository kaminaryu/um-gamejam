class_name Mechanism
extends Node2D

@export var controlled: bool

func _ready() -> void :
    controlled = false
    toggle_control()
    
func toggle_control() -> void :
    controlled = !controlled
    
    if (controlled) :
        $Controlled.enable(true)
        $Uncontrolled.enable(false)
        print("Mechanism Is Controlleable")
    else :
        $Controlled.enable(false)
        $Uncontrolled.enable(true)
        print("Mechanism Is Uncontrolleable")


    
