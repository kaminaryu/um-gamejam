extends TextureButton


func _on_mouse_entered() -> void:
	modulate.r = 1.5
	modulate.g = 1.5
	modulate.b = 1.5

func _on_mouse_exited() -> void:
	modulate.r = 1.0
	modulate.g = 1.0
	modulate.b = 1.0
