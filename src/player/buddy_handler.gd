extends Node2D

const BUDDY_SCENE := preload("res://src/player/buddy.tscn")

func _input(event: InputEvent) -> void :
    if (event.is_action_pressed("(DEBUG)SpawnBuddy")) :
        print("DEBUG: Spawning Buddy")
        spawn_buddy()

func spawn_buddy() -> void :
    var random_range := randf_range(5, 10) * 32
    var random_angle := randf_range(-PI, PI)
    
    var spawn_pos: Vector2 = (Vector2.RIGHT * random_range).rotated(random_angle)
    
    var buddy = BUDDY_SCENE.instantiate()
    buddy.position = spawn_pos
    
    get_tree().root.add_child(buddy)
