extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _on_resume_button_pressed() -> void:
	$ButtonSfx.play_audio()
	animation_player.play('close');

func _on_settings_button_pressed() -> void:
	$ButtonSfx.play_audio()
	$SettingsMenu.open_settings()

func _on_restart_button_pressed() -> void:
	WaveHandler.reset()
	GameMaster.reset()
	$ButtonSfx.play_audio()
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")

func _on_menu_button_pressed() -> void:
	WaveHandler.reset()
	GameMaster.reset()
	$ButtonSfx.play_audio()
	get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == 'close') : GameMaster.pause_game(false);
