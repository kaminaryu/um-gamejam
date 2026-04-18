extends Node

signal increased_wave
signal started_wave
signal finished_wave

var wave_number: int
var enemy_count: int

var waves = [
    {"Green": 5, "Red": 5, "Blue": 0, "Yellow": 0, "Split": 0, "Big": 0, "Fast": 0, "Shoot": 0},
    {"Green": 5, "Red": 4, "Blue": 2, "Yellow": 0, "Split": 0, "Big": 0, "Fast": 0, "Shoot": 0},
    {"Green": 4, "Red": 4, "Blue": 3, "Yellow": 0, "Split": 1, "Big": 0, "Fast": 0, "Shoot": 0},
    {"Green": 3, "Red": 3, "Blue": 3, "Yellow": 2, "Split": 1, "Big": 1, "Fast": 0, "Shoot": 0},
    {"Green": 3, "Red": 2, "Blue": 3, "Yellow": 2, "Split": 2, "Big": 1, "Fast": 1, "Shoot": 0},
    {"Green": 2, "Red": 2, "Blue": 3, "Yellow": 3, "Split": 2, "Big": 1, "Fast": 1, "Shoot": 1},
    {"Green": 2, "Red": 2, "Blue": 3, "Yellow": 4, "Split": 3, "Big": 2, "Fast": 2, "Shoot": 1},
    {"Green": 0, "Red": 2, "Blue": 3, "Yellow": 4, "Split": 3, "Big": 2, "Fast": 3, "Shoot": 2},
    {"Green": 0, "Red": 0, "Blue": 2, "Yellow": 4, "Split": 4, "Big": 3, "Fast": 3, "Shoot": 3},
    {"Green": 0, "Red": 0, "Blue": 2, "Yellow": 4, "Split": 4, "Big": 3, "Fast": 4, "Shoot": 3},
    {"Green": 0, "Red": 0, "Blue": 1, "Yellow": 3, "Split": 4, "Big": 4, "Fast": 5, "Shoot": 4},
    {"Green": 0, "Red": 0, "Blue": 0, "Yellow": 3, "Split": 5, "Big": 4, "Fast": 6, "Shoot": 5},
    {"Green": 0, "Red": 0, "Blue": 0, "Yellow": 2, "Split": 5, "Big": 5, "Fast": 7, "Shoot": 5},
    {"Green": 0, "Red": 0, "Blue": 0, "Yellow": 0, "Split": 5, "Big": 6, "Fast": 9, "Shoot": 6},
    {"Green": 0, "Red": 0, "Blue": 0, "Yellow": 0, "Split": 6, "Big": 7, "Fast": 10, "Shoot": 7},
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
