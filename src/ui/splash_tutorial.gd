extends CanvasLayer

var SCREENS = ["Controls", "Mechanism", "Buddy", "Health", "Difficulty"]
var chosen_screen := 0

func change_screen() -> void :
	var children := get_children()
	
	for child in children :
		if (child.get_class() != "Control") :
			continue

		if (child.name == SCREENS[chosen_screen]) :
			child.visible = true
		else :
			child.visible = false



func _on_prev_button_down() -> void:
	chosen_screen -= 1
	change_screen()
	$ButtonSfx.play_audio()


func _on_next_button_down() -> void:
	chosen_screen += 1
	change_screen()
	$ButtonSfx.play_audio()


func _on_play_button_button_down() -> void:
	$ButtonSfx.play_audio()
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")


func _on_back_button_button_down() -> void:
	visible = false
	$ButtonSfx.play_audio()


func _on_easy_button_down() -> void:
	GameMaster.game_difficulty = "Easy"
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")


func _on_medium_button_down() -> void:
	GameMaster.game_difficulty = "Medium"
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")


func _on_hard_button_down() -> void:
	GameMaster.game_difficulty = "Hard"
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")


func _on_impossible_button_down() -> void:
	GameMaster.game_difficulty = "Impossible"
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")
