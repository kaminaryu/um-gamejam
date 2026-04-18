extends HBoxContainer

var player: CharacterBody2D
var mech_handler: Node2D
var mech_dict: Dictionary

func _ready():
    WaveHandler.started_wave.connect(_on_next_wave)
    player = get_tree().get_first_node_in_group("Player")
    mech_handler = player.get_node("MechanismHandler")
    mech_dict = mech_handler.mechanism_controllable

func _on_next_wave(data):
    var mech_arr = [
        mech_dict["Aiming"]["enabled"], 
        mech_dict["Dash"]["enabled"], 
        mech_dict["Shooting"]["enabled"], 
        mech_dict["Vision"]["enabled"]
    ]
   
    var icons = get_children()
    for i in range(icons.size()):
        var x_node = icons[i].get_node_or_null("X")
        if x_node:
            x_node.visible = not mech_arr[i]
