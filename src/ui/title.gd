extends Label

func _draw() -> void:
	# 1. Get the size of the rendered text
	var text_size = get_theme_font("font").get_string_size(text, HORIZONTAL_ALIGNMENT_CENTER, -1, get_theme_font_size("font_size"))
	
	# 2. Define the start and end points of the line
	var line_y = text_size.y - 4 # Positioned 2 pixels below the text
	var start_pos = Vector2(0, line_y)
	var end_pos = Vector2(text_size.x, line_y)
	
	# 3. Draw the line using the label's modulate color
	draw_line(start_pos, end_pos, modulate, 4.0)
