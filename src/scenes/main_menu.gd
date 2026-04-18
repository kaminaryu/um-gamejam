extends Control

func _ready() -> void :
	MusicPlayer.switch_to_track("Mainmenu")

func _on_play_button_pressed() -> void:
	$ButtonSfx.play_audio()
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")


func _on_options_button_pressed() -> void:
	$ButtonSfx.play_audio()
	$SettingsMenu.open_settings()


func _on_tutorial_button_pressed() -> void:
	$ButtonSfx.play_audio()
	$TutorialMenu.show_tutorial_select();
