# CountdownUI.gd
extends Label

func _ready() -> void:
	# 1. Reset the wave logic via the Autoload
	WaveHandler.reset()
	await get_tree().create_timer(1.0).timeout
	# 2. Start the countdown sequence
	run_countdown()

func run_countdown():
	# We use a loop to count down
	for i in range(3, 0, -1):
		text = str(i)
		
		# Juice it: Make the number "pop"
		pivot_offset = size / 2
		scale = Vector2.ZERO
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_ELASTIC)
		
		await get_tree().create_timer(1.0).timeout
	
	# 3. Final message
	text = "GO!"
	await get_tree().create_timer(0.5).timeout
	
	# 4. Tell the WaveHandler to actually begin!
	WaveHandler.start_wave()
	
	# 5. Hide the countdown
	queue_free()
