extends Node
@onready var positionmusic = MusicManager.get_playback_position()
@export var level : int = 1
func _ready():
	
	match level:
		1:
			if MusicManager.stream == MusicManager.N_1:
				pass
			else:
				MusicManager.startplay(MusicManager.N_1)
		2:
			if MusicManager.stream == MusicManager.N_2:
				pass
			else:
				MusicManager.startplay(MusicManager.N_2)
