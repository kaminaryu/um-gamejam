extends Marker2D

# Map the names in your table to your actual .tscn files
@export var enemy_library: Dictionary = {
	"Green": preload("res://src/enemy/green_enemy.tscn"),
	"Red": preload("res://src/enemy/red_enemy.tscn"),
	"Blue": preload("res://src/enemy/blue_enemy.tscn"),
	"Yellow": preload("res://src/enemy/yellow_enemy.tscn"),
	"Split": preload("res://src/enemy/split_enemy.tscn"),
	"Big": preload("res://src/enemy/big_enemy.tscn"),
	"Fast": preload("res://src/enemy/fast_enemy.tscn"),
	"Shoot": preload("res://src/enemy/shoot_enemy.tscn")
	# Add the rest: "Big", "Fast", "Shoot"
}

@export var spawn_radius: float = 1500.0
var current_wave_enemies = []

func _ready() -> void:
	WaveHandler.started_wave.connect(_on_start_wave)
	WaveHandler.finished_wave.connect(_on_wave_finished)
	
func _on_start_wave(data: Dictionary):
	print("Spawning")
	spawn_table_wave(data)
	
func _on_wave_finished():
	print("Wave Finished")
	await get_tree().create_timer(2.0).timeout
	
	
func spawn_table_wave(wave_data: Dictionary) -> void:
	
	# Loop through each entry in the table row (e.g., "Green": 10)
	for enemy_type in wave_data:
		var count = wave_data[enemy_type]
		
		# Skip if the count is 0 or if we don't have that enemy in our library
		if count <= 0 or not enemy_library.has(enemy_type):
			continue
			
		for i in range(count):
			var enemy = enemy_library[enemy_type].instantiate()
			
			# Position
			var random_offset = Vector2(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius))
			enemy.global_position = global_position + random_offset
			
			# Visual Pop-in
			_apply_spawn_effects(enemy)
			
			# Disable movement initially
			var move_comp = enemy.get_node_or_null("MovementComponent")
			if move_comp: move_comp.enabled = false
			
			get_tree().current_scene.add_child(enemy)
			current_wave_enemies.append(enemy)
			
			# Stagger slightly so 15 enemies don't lag the game
			await get_tree().create_timer(0.1).timeout

	# Wait for animations, then activate
	await get_tree().create_timer(0.5).timeout
	for enemy in current_wave_enemies:
		if is_instance_valid(enemy):
			var move_comp = enemy.get_node_or_null("MovementComponent")
			if move_comp: move_comp.enabled = true

func _apply_spawn_effects(node: Node2D):
	node.scale = Vector2.ZERO
	node.modulate.a = 0
	var tween = create_tween().set_parallel(true)
	tween.tween_property(node, "scale", Vector2.ONE, 0.6).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "modulate:a", 1.0, 0.3)
