extends Node
signal increased_wave
signal started_wave
signal finished_wave
var wave_number: int
var enemy_count: int
var waves = [
    {"Green": 5, "Red": 5}, 
    {"Green": 5, "Red": 5, "Blue": 5, "Yellow": 5},
    {"Green": 5, "Red": 5, "Split": 5},
    {"Green": 10, "Blue": 10, "Split": 5},
    {"Green": 5, "Red": 7, "Yellow": 5, "Split": 5, "Fast": 3},
    {"Green": 5, "Blue": 5, "Yellow": 2, "Split": 8, "Big": 2,"Fast": 3},
    {"Green": 5, "Red": 5,"Blue": 5, "Yellow": 5, "Split": 3, "Big": 2,"Fast": 3, "Shoot": 2},
    {"Green": 10, "Red": 5,"Blue": 5, "Yellow": 5, "Split": 5, "Big": 2,"Fast": 5, "Shoot": 2}
]
func _ready() -> void :
    print("wave is ready")
    reset()
    
    
func reset() -> void :
    wave_number = 1
    enemy_count = 0
    
    
func register_enemy():
    enemy_count+=1
    
    
func enemy_defeated():
    enemy_count-=1
    print("Enemy Left: ", enemy_count)
    if enemy_count <= 0:
        finished_wave.emit()
        increase_wave()
        var sfx = SfxPlayer.get_audio("WaveCompleted")
        _play_global_sfx(sfx)
        
        
func _input(event: InputEvent) -> void :
    if (event.is_action_pressed("(DEBUG)IncreaseWave")) :
        increase_wave()
        start_wave()
        
        
func increase_wave() -> void :
    wave_number += 1
    print("Wave: ", wave_number)
    await get_tree().create_timer(2.0).timeout
    increased_wave.emit()
    await get_tree().create_timer(2.0).timeout
    start_wave()
    
    
func start_wave():
    print("Wave Start")
    var data: Dictionary
    if wave_number <= waves.size():
        data = waves[wave_number-1]
    else:
        data = waves[waves.size()-1]
    started_wave.emit(data)


func _play_global_sfx(stream: AudioStream):
    if stream:
        var player = AudioStreamPlayer.new()
        player.stream = stream
        
        player.bus = &"SFX"
        get_tree().root.add_child(player)
        
        player.play()
        player.finished.connect(player.queue_free)
