extends Node
@onready var positionmusic = MusicManager.get_playback_position()
@export var level : int = 1
func _ready():
	
	match level:
		1:
			if MusicManager.stream == MusicManager.N_1:
				if MusicManager.has_stream_playback():
					pass
				else:
					MusicManager.startplay(MusicManager.N_1)
					
			else:
				MusicManager.startplay(MusicManager.N_1)
		2:
			if MusicManager.stream == MusicManager.N_2:
				if MusicManager.has_stream_playback():
					pass
				else:
					MusicManager.startplay(MusicManager.N_2)
			else:
				MusicManager.startplay(MusicManager.N_2)
