extends Control

func _process(delta: float) -> void:
	$Easy.visible = false
	$Medium.visible = false
	$Hard.visible = false
	$Impossible.visible = false
	
	get_node(GameMaster.game_difficulty).visible = true 
