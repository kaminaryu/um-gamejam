extends CanvasLayer

func _on_restart_button_pressed() -> void:
    WaveHandler.reset()
    GameMaster.reset()
    $ButtonSfx.play_audio()
    get_tree().change_scene_to_file("res://src/scenes/main.tscn")
    get_tree().paused = false
    queue_free()

func _on_menu_button_pressed() -> void:
    WaveHandler.reset()
    GameMaster.reset()
    $ButtonSfx.play_audio()
    get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
    get_tree().paused = false
    queue_free()
