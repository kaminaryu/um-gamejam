extends Node

const PAUSE_MENU_SCENE := preload("res://src/scenes/pause_menu.tscn")
const DEATH_MENU_SCENE := preload("res://src/scenes/death_screen.tscn")

@onready var pause_menu: CanvasLayer = null
var game_paused: bool
var is_ingame: bool


func _ready() -> void :
	reset()
	
	
func reset() -> void :
	pause_game(false)
	delete_all_entities()
	is_ingame = false
	
	
func delete_all_entities() -> void :
	for entity in get_tree().get_nodes_in_group("Entities") :
		entity.queue_free()
		
	
func pause_game(pause: bool) -> void :
	if (not is_ingame) :
		return
		
	game_paused = pause
	
	if (pause) :
		pause_menu = PAUSE_MENU_SCENE.instantiate()
		get_tree().paused = true
		get_tree().root.add_child(pause_menu)
	else :
		if (not pause_menu) :
			return
		get_tree().paused = false
		pause_menu.queue_free()


func player_death() -> void :
	var death_menu = DEATH_MENU_SCENE.instantiate()
	get_tree().paused = true
	get_tree().root.add_child(death_menu)
	
	MusicPlayer.switch_to_track("Gameover")


func _input(event: InputEvent) -> void :
	if (event.is_action_pressed("pause_game")) :
		if (game_paused) :
			pause_game(false)
		else :
			pause_game(true)
