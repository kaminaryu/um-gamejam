extends Node2D

const BULLET_SCENE = preload("res://src/mechanism/shooting/bullet.tscn")

var shootingPaused = false


func enable(enable: bool) -> void :
	if (enable) :
		process_mode = Node.PROCESS_MODE_ALWAYS
	else :
		process_mode = Node.PROCESS_MODE_DISABLED
		
		
func _process(delta: float) -> void :
	get_parent().look_at(get_global_mouse_position())


func _on_shooting_delay_timeout() -> void:
	shootingPaused = false
