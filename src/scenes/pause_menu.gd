extends CanvasLayer

func _on_resume_button_pressed() -> void:
    GameMaster.pause_game(false)

func _on_settings_button_pressed() -> void:
    $SettingsMenu.open_settings()
        
func _on_restart_button_pressed() -> void:
    WaveHandler.reset()
    GameMaster.reset()
    get_tree().change_scene_to_file("res://src/scenes/main.tscn")

func _on_menu_button_pressed() -> void:
    WaveHandler.reset()
    GameMaster.reset()
    get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
