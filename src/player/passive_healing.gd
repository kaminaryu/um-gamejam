extends Node2D


func init_healing() -> void :
    $StartingCooldown.start()

func stop_healing() -> void :
    $StartingCooldown.stop()
    $Cooldown.stop()


func _on_starting_cooldown_timeout() -> void:
    start_healing()

func _on_cooldown_timeout() -> void:
    heal()


func start_healing() -> void :
    $Cooldown.start()
    
    
func heal() -> void :
    var player: Node = get_parent()
    player.heal()
