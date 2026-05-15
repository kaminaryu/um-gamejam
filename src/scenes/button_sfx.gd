extends AudioStreamPlayer


func play_audio() -> void :
	var audio = AudioStreamPlayer.new()
	audio.stream = SfxPlayer.get_audio("ButtonClick")
	get_tree().root.add_child(audio)
	audio.pitch_scale = randf_range(0.8, 1.2)
	audio.play()
	audio.finished.connect(audio.queue_free)

	
