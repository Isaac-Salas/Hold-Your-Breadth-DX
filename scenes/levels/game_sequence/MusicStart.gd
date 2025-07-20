extends Node
class_name MusicSubmanager
@onready var positionmusic = MusicManager.get_playback_position()
@export var level : int = 1
@export var playback_speed : int = 1
@export var loop : bool = true
#@export var fades : bool = false

func _ready():
	MusicManager.finished.connect(looper)
	check_manager()
	
func looper():
	if loop == true:
		MusicManager.play()
		print("TryLoop on:", MusicManager.get_stream_playback())

func check_manager():
	match level:
		1:
			compare_stream(1)
		2:
			compare_stream(2)

func compare_stream(matched : int):
	var lookup = 'N_'+ str(matched)
	if MusicManager.stream == MusicManager.get(lookup):
		if MusicManager.has_stream_playback():
			pass
		else:
			#MusicManager.fade(-80.0)
			#await MusicManager.fade_audio.finished
			MusicManager.startplay(MusicManager.get(lookup),playback_speed)
			#MusicManager.fade()
			
	else:
		if MusicManager.has_stream_playback():
			#MusicManager.fade(-80.0, 3.0)
			#await MusicManager.fade_audio.finished
			MusicManager.startplay(MusicManager.get(lookup),playback_speed)
			#MusicManager.fade()
		else:
			MusicManager.startplay(MusicManager.get(lookup),playback_speed)
			#MusicManager.fade()
		
