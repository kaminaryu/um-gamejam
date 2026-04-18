extends CanvasLayer

# 1. Reference your slider nodes
@onready var master_slider = $Control/Master/MasterControl
@onready var music_slider  = $Control/Music/MusicControl
@onready var sfx_slider    = $Control/SFX/SFXControl

func _ready() -> void:
    hide()
    
func _input(event: InputEvent) -> void :
    if (event.is_action_pressed("pause_game")) :
        close_settings()
    

func open_settings() -> void:
    # 2. Sync sliders with the actual audio bus levels
    master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(&"Master")))
    music_slider.value  = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(&"Music")))
    sfx_slider.value    = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(&"SFX")))
    
    show()

func close_settings() -> void:
    hide()

func _on_close_pressed() -> void:
    close_settings()
    $ButtonSfx.play_audio()


# --- Slider Signal Handlers ---
func _on_master_control_value_changed(value: float) -> void:
    AudioManager.set_bus_volume_percent(&"Master", value)

func _on_music_control_value_changed(value: float) -> void:
    AudioManager.set_bus_volume_percent(&"Music", value)

func _on_sfx_control_value_changed(value: float) -> void:
    AudioManager.set_bus_volume_percent(&"SFX", value)
