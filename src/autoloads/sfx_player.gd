extends Node

const SFX = {
    "Normal": {
        #"PlayerHurt": preload("res://assets/soundeffects/player_hurt_1.wav"),
        #"PlayerShoot": preload("res://assets/soundeffects/player_shoot.wav"),
        #"EnemyDeath": preload("res://assets/soundeffects/enemy_die_1.wav"),
        #"EnemyHurt": preload("res://assets/soundeffects/enemy_hurt_1.wav"),
        #"EnemySplit": preload("res://assets/soundeffects/enemy_split_1.wav"),
        #"ButtonClick": preload("res://assets/soundeffects/button.wav"),
        #"PickupCard": preload("res://assets/soundeffects/pickup_2.wav"),
        #"BuddySpawn": preload("res://assets/soundeffects/buddy_spawn_1.wav"),
        #"BulletBounce": preload("res://assets/soundeffects/bullet_bounce_2.wav"),
        #"BuddyBounce": preload("res://assets/soundeffects/bullet_bounce_2.wav"),
        #"WaveCompleted": preload("res://assets/soundeffects/wave_complete_1.wav"),
    },
    "Goofy": {
        "PlayerHurt": preload("res://assets/soundeffects/player_hurt_1.wav"),
        "PlayerShoot": preload("res://assets/soundeffects/player_shoot.wav"),
        "EnemyDeath": preload("res://assets/soundeffects/enemy_die_1.wav"),
        "EnemyHurt": preload("res://assets/soundeffects/enemy_hurt_1.wav"),
        "EnemySplit": preload("res://assets/soundeffects/enemy_split_1.wav"),
        "ButtonClick": preload("res://assets/soundeffects/button.wav"),
        "PickupCard": preload("res://assets/soundeffects/pickup_2.wav"),
        "BuddySpawn": preload("res://assets/soundeffects/buddy_spawn_1.wav"),
        "BulletBounce": preload("res://assets/soundeffects/bullet_bounce_1.wav"),
        "BuddyBounce": preload("res://assets/soundeffects/bullet_bounce_2.wav"),
        "WaveCompleted": preload("res://assets/soundeffects/wave_complete_1.wav"),
    },
}

const SFX_MODE := "Goofy"

func get_audio(audio_name: String) -> AudioStream :
    return SFX[SFX_MODE][audio_name]
