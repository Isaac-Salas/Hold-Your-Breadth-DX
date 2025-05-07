extends Node
var positionmusic = MusicManager.get_playback_position()
@export var level : int = 1
func _ready():
	
	if MusicManager.stream != null:
		if positionmusic != 0.0:
			pass
		else:
			match level:
				1:
					MusicManager.startplay(MusicManager.N_1)
				2:
					MusicManager.startplay(MusicManager.N_2)
					
	else:
		match level:
			1:
				MusicManager.startplay(MusicManager.N_1)
			2:
				MusicManager.startplay(MusicManager.N_2)
