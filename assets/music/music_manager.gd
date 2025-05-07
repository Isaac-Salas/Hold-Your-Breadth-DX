extends AudioStreamPlayer
const HTB_SONG_N_1 = preload("res://assets/music/HtbSongN1.mp3")
const N_2 = preload("res://assets/music/N2.mp3")
const N_1 = preload("res://assets/music/HYbGameMixN1.mp3")
var songvolume : float = -10.0


func startplay(song):
	stream = song
	volume_db = songvolume
	bus = "Music"
	play(0.0)
	
func stopplay():
	stop()
