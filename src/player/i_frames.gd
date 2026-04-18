extends Node2D

signal finished_iframe


func apply_iframe() -> void :
    $AnimationPlayer.play("flashing")
    


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name != "flashing") :
        return

    finished_iframe.emit()
