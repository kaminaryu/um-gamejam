extends CharacterBody2D

class_name Enemy

@export var _enemy_name: String
@export var _health: int
@export var _damage: int
@export var _speed: float

func _ready() -> void:
    WaveHandler.register_enemy()

func set_enemy_name(name: String):
    _enemy_name = name

func set_max_health(health: int):
    _health = health
    
func set_damage(damage: int):
    _damage = damage
    
func set_speed(speed: int):
    _speed = speed

func take_damage(dmg: int):
    _health -= dmg
    if _health <= 0:
        die()
        
    var sfx = SfxPlayer.get_audio("EnemyHurt")
    _play_global_sfx(sfx)
    

func die():
    death.emit()
    WaveHandler.enemy_defeated()
    queue_free()
    
    var sfx = SfxPlayer.get_audio("EnemyDeath")
    _play_global_sfx(sfx)
    
signal death


func _play_global_sfx(stream: AudioStream):
    if stream:
        var player = AudioStreamPlayer2D.new()
        player.stream = stream
        player.pitch_scale = randf_range(0.9, 1.1)
        player.global_position = global_position

        player.bus = &"SFX"
        get_tree().root.add_child(player)


        player.play()
        player.finished.connect(player.queue_free)
