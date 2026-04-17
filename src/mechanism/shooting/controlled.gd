extends Node2D

var shootingPaused = false

func enable(enable: bool) -> void :
	if (enable) :
		process_mode = Node.PROCESS_MODE_ALWAYS
	else :
		process_mode = Node.PROCESS_MODE_DISABLED
		
		
func _process(delta: float) -> void :
	if (Input.is_action_pressed("shoot")) :
		if (shootingPaused) :
			return
			
		$ShootingDelay.start()
		shootingPaused = true
			
		get_parent().shoot()


func _on_shooting_delay_timeout() -> void:
	shootingPaused = false
