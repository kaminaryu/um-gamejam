extends PointLight2D

@export var controlled: bool

const DEFAULT_TEXTURE_SCALE := 24.0
const SPEED := 5.0

var new_scale: float = DEFAULT_TEXTURE_SCALE

func _ready() -> void :
    controlled = false
    toggle_control()
    
func toggle_control() -> void :
    controlled = !controlled
    
    if (controlled) :
        texture_scale = DEFAULT_TEXTURE_SCALE
        $FluctuationDelay.stop()
        print("Vision Is Normal")
    else :
        $FluctuationDelay.start(5)
        print("Vison Is Fluctuating")
  
func _process(delta: float) -> void :
    if (controlled) :
        return
        
    #larping
    texture_scale = lerp(texture_scale, new_scale, SPEED * delta)      
        
func fluctuate_light() -> void :
    new_scale = randf_range(8, 16)
    

func _on_fluctuation_delay_timeout() -> void:
    var random_delay := randf_range(3, 7)
    $FluctuationDelay.start(random_delay)
    
    fluctuate_light()
    print("Vision Fluctuation")
