extends Node

signal increased_wave

var wave_number: int = 1

func _input(event: InputEvent) -> void :
    if (event.is_action_pressed("(DEBUG)IncreaseWave")) :
        increase_wave()
        
        
func increase_wave() -> void :
    wave_number += 1
    print("Wave: ", wave_number)
    increased_wave.emit()    
    
