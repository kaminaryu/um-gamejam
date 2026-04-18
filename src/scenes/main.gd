extends Node2D

func _ready() -> void :
    MusicPlayer.switch_to_track("Gameplay")
    #GameMaster.is_ingame = true
