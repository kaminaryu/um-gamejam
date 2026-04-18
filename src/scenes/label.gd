extends Label

var audio: AudioStreamPlayer

func _ready() -> void:
    WaveHandler.increased_wave.connect(_on_wave_increased)
    # Start the very first sequence 
    if WaveHandler.wave_number == 1:
        run_opening_sequence()
    else:
        _on_wave_increased()

func run_opening_sequence():
    # dont allow player to pause here
    #GameMaster.is_ingame = false
    
    visible = true
    # Standard 3, 2, 1, GO loop
    for i in range(3, 0, -1):
        display_text(str(i))
        await get_tree().create_timer(1).timeout
    display_text("GO!")
    await get_tree().create_timer(1).timeout
    
    WaveHandler.start_wave()
    visible = false
    
    GameMaster.is_ingame = true

func _on_wave_increased() -> void:
    # This handles Wave 2, 3, etc.
    if WaveHandler.wave_number > 1:
        visible = true
        display_text("WAVE " + str(WaveHandler.wave_number))
        
        # Show it for a moment
        await get_tree().create_timer(1.5).timeout
        
        # Start the wave immediately after announcement
        WaveHandler.start_wave()
        visible = false

# Helper function to handle the "Pop" animation so we don't repeat code
func display_text(new_text: String):
    text = new_text
    pivot_offset = size / 2
    scale = Vector2.ZERO
    var tween = create_tween()
    tween.tween_property(self, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_SINE)
