extends Node2D

const BULLET_SCENE = preload("res://src/mechanism/shooting/bullet.tscn")

@export var controlled: bool
const PLAYER_SIZE := 48


func _ready() -> void :
	controlled = false
	toggle_control()
	
func toggle_control() -> void :
	controlled = !controlled
	
	if (controlled) :
		$Controlled.enable(true)
		$Uncontrolled.enable(false)
		print("Aiming Is Controlleable")
	else :
		$Controlled.enable(false)
		$Uncontrolled.enable(true)
		print("Aiming Is Uncontrolleable")


func on_shooting() -> void :
	var bullet := BULLET_SCENE.instantiate()
	bullet.global_position = global_position
	bullet.rotation = rotation
	
	# offset the bullet so it doesnt clip with the player
	bullet.global_position += Vector2.RIGHT.rotated(bullet.rotation) * PLAYER_SIZE * 1.75
	
	get_tree().root.add_child(bullet)
