extends TextureProgressBar

var player_node: CharacterBody2D

func _ready():
    var player = get_tree().get_first_node_in_group("Player")
    if player:
        player.health_changed.connect(update_bar)

func update_bar(new_health):
    value = new_health 
    print("Current Health: ",value)
