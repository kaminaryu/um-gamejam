extends AudioStreamPlayer2D

func _ready() -> void :
    stream = SfxPlayer.get_audio("EnemySplit")
