extends AudioStreamPlayer


func play_audio() -> void :
    var audio = AudioStreamPlayer.new()
    audio.stream = SfxPlayer.get_audio("ButtonClick")
    get_tree().root.add_child(audio)
    audio.play()
    audio.finished.connect(audio.queue_free)
