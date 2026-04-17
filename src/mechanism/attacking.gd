extends Node2D

func _ready() -> void :
    $ShootingMech.shot.connect($AimingMechanism.on_shooting)
    
