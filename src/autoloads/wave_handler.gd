extends Node

signal increased_wave
signal started_wave(wave_data: Dictionary)
signal finished_wave

var wave_number: int = 1
var enemy_count: int = 0
var is_wave_transitioning: bool = false # Guard variable	

var waves = [

	{"Green": 0, "Red": 0, "Blue": 0, "Yellow": 2, "Split": 5, "Big": 5, "Fast": 7, "Shoot": 5},
	{"Green": 0, "Red": 0, "Blue": 0, "Yellow": 0, "Split": 5, "Big": 6, "Fast": 9, "Shoot": 6},
	{"Green": 0, "Red": 0, "Blue": 0, "Yellow": 0, "Split": 6, "Big": 7, "Fast": 10, "Shoot": 7},
]

func _ready() -> void:
	reset()

func reset() -> void:
	wave_number = 1
	enemy_count = 0
	is_wave_transitioning = false

func register_enemy():
	enemy_count += 1
	
func enemy_defeated():
	enemy_count -= 1
	if enemy_count <= 0 and not is_wave_transitioning:
		process_wave_completion()

func _input(event: InputEvent) -> void:
	# Use only one call here; increase_wave handles the start logic
	if event.is_action_pressed("(DEBUG)IncreaseWave") and not is_wave_transitioning:
		process_wave_completion()

func process_wave_completion() -> void:
	is_wave_transitioning = true
	finished_wave.emit()
	
	wave_number += 1
	await get_tree().create_timer(2.0).timeout
	
	increased_wave.emit()
	await get_tree().create_timer(2.0).timeout
	
	start_wave()
	is_wave_transitioning = false # Ready for next wave

func start_wave():
	var data: Dictionary
	if wave_number <= waves.size():
		data = waves[wave_number - 1]
	else:
		data = waves[waves.size() - 1]
	
	started_wave.emit(data)
