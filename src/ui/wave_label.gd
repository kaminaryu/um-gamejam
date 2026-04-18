extends Label

func _ready():
	WaveHandler.started_wave.connect(_update_label)
	
func _update_label(data):
	text = str(WaveHandler.wave_number)
