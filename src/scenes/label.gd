extends Label

var audio: AudioStreamPlayer
var player: CharacterBody2D

var subtext: String

func _ready() -> void:
    WaveHandler.increased_wave.connect(_on_wave_increased)
    player = get_tree().get_first_node_in_group("Player")
    player.get_node("MechanismHandler").spawned_buddy.connect(_on_buddy_spawned)
    player.get_node("MechanismHandler").disabled_mechanism.connect(_on_mechanism_disabled)
    # Start the very first sequence 
    if WaveHandler.wave_number == 1:
        run_opening_sequence()
    else:
        _on_wave_increased()

func _on_buddy_spawned(data):
    subtext = data
    
func _on_mechanism_disabled(data):
    subtext = "System Error!\n{0} Malfunction".format([data])
    

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
        
        if(subtext):
            display_text(subtext)
            subtext = ""
        else:
            display_text("System Update Succesfully!")
        
        # Show it for a moment
        await get_tree().create_timer(2).timeout
        
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
