extends Node2D

func _ready() -> void :
    $ShootingMech.shot.connect($AimingMech.on_shooting)
