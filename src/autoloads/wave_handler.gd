extends Node

signal increased_wave
signal started_wave
signal finished_wave

var wave_number: int
var enemy_count: int

var waves = [
	{"Green": 5, "Red": 5}, # Wave 1
	{"Green": 5, "Red": 5, "Blue": 5}, # Wave 2
	{"Green": 5, "Red": 5, "Blue": 5, "Yellow": 5},
	{"Green": 10, "Red": 5, "Split": 5}
]

func _ready() -> void :
	print("wave is ready")
	reset()

func reset() -> void :
	wave_number = 4
	enemy_count = 0

func register_enemy():
	enemy_count+=1
	print("Total Enemy: ", enemy_count)
	
func enemy_defeated():
	enemy_count-=1
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
	if wave_number <= waves.size():
		var data = waves[wave_number-1]
		started_wave.emit(data)
	else:
		print("Waves finished")
