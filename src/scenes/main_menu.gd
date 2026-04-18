extends Control

func _ready() -> void :
    MusicPlayer.switch_to_track("Mainmenu")

func _on_play_button_pressed() -> void:
    get_tree().change_scene_to_file("res://src/scenes/main.tscn")
