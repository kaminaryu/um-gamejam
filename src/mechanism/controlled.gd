extends Node2D



func enable(enable: bool) -> void :
    if (enable) :
        process_mode = Node.PROCESS_MODE_ALWAYS
    else :
        process_mode = Node.PROCESS_MODE_DISABLED
