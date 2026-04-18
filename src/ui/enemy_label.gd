extends Label

func _process(delta: float) -> void:
	text = str(WaveHandler.enemy_count)
