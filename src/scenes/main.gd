extends Node2D

func _ready() -> void :
	MusicPlayer.switch_to_track("Gameplay")
	#GameMaster.is_ingame = true


func _on_aim_mouse_entered() -> void:
	$CanvasLayer/AimingTip.visible = true

func _on_aim_mouse_exited() -> void:
	$CanvasLayer/AimingTip.visible = false


func _on_dash_mouse_entered() -> void:
	$CanvasLayer/DashTip.visible = true

func _on_dash_mouse_exited() -> void:
	$CanvasLayer/DashTip.visible = false


func _on_shoot_mouse_entered() -> void:
	$CanvasLayer/ShootingTip.visible = true

func _on_shoot_mouse_exited() -> void:
	$CanvasLayer/ShootingTip.visible = false


func _on_vision_mouse_entered() -> void:
	$CanvasLayer/VisionTip.visible = true


func _on_vision_mouse_exited() -> void:
	$CanvasLayer/VisionTip.visible = false
