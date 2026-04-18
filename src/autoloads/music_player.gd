extends Node

@onready var music_player := AudioStreamPlayer.new()

const MUSICS = {
    "Mainmenu": preload("res://assets/soundtracks/Choose Your Racer.wav"),
    "Gameplay": preload("res://assets/soundtracks/Bouncing Pyramids.wav"),
    "Gameover": preload("res://assets/soundtracks/You Lost.wav"),
}

func _ready() -> void :
    add_child(music_player)
    # this is a stringID type shit, instead of checking chars one by one, each string have ID
    # yk.... LIKE A POINTER
    music_player.bus = &"Music"

func switch_to_track(name: String) -> void :
    if not MUSICS.has(name) :
        push_error("Music Doesnt Exist")
        return
        
    var music_asset = MUSICS[name]
    if music_player.stream == music_asset and music_player.playing :
        return
        
    music_player.stream = music_asset
    music_player.play()
