# wave_handler.gd
extends Node

signal increased_wave
signal started_wave(wave_data: Dictionary)
signal finished_wave

var wave_number: int = 1
var enemy_count: int = 0
var is_wave_transitioning: bool = false

var _diff_data: Dictionary = {}

const NORMAL_TYPES := ["Green", "Red", "Blue", "Yellow"]

const TYPE_MAP := {
	"split": "Split",
	"big":   "Big",
	"fast":  "Fast",
	"shoot": "Shoot",
}

func _ready() -> void:
	reset()

func _load_difficulty_data() -> void:
	var file := FileAccess.open("res://src/enemy/enemy_spawner/wave_data.json", FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_as_text())
	file.close()

	var all_data: Dictionary = json.get_data()

	var diff: String = GameMaster.game_difficulty
	
	print(diff, ' ', all_data.has(diff))
	
	if diff == "" or not all_data.has(diff):
		diff = "Easy"

	_diff_data = all_data[diff]

func reset() -> void:
	wave_number = 1
	enemy_count = 0
	is_wave_transitioning = false

func register_enemy() -> void:
	enemy_count += 1

func enemy_defeated() -> void:
	enemy_count -= 1
	if enemy_count <= 0 and not is_wave_transitioning:
		process_wave_completion()

func _input(event: InputEvent) -> void:
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
	is_wave_transitioning = false

func start_wave() -> void:
	_load_difficulty_data()
	var data := _compute_wave(wave_number)
	started_wave.emit(data)

func _compute_wave(wave: int) -> Dictionary:
	var result := {}

	for json_key in _diff_data.keys():
		var cfg: Dictionary = _diff_data[json_key]

		if wave < cfg["starting_wave"]:
			continue

		if cfg.has("retire_wave") and wave >= cfg["retire_wave"]:
			continue

		var waves_past_start: int = wave - cfg["starting_wave"]
		var amount: float = cfg["starting_amount"]

		if cfg.has("increment_multiplier"):
			amount = cfg["starting_amount"] * pow(cfg["increment_multiplier"], waves_past_start)
		elif cfg.has("increment_step"):
			amount = cfg["starting_amount"] + cfg["increment_step"] * waves_past_start

		var count: int = max(0, int(round(amount)))
		if count == 0:
			continue

		if json_key == "normal":
			# Distribute count randomly across colored enemy types
			for i in range(count):
				var picked: String = NORMAL_TYPES[randi() % NORMAL_TYPES.size()]
				result[picked] = result.get(picked, 0) + 1
		else:
			var spawn_key: String = TYPE_MAP.get(json_key, json_key)
			result[spawn_key] = count

	return result
