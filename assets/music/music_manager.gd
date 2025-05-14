extends AudioStreamPlayer
const HTB_SONG_N_1 = preload("res://assets/music/HtbSongN1.mp3")
const N_2 = preload("res://assets/music/N2.mp3")
const N_1 = preload("res://assets/music/HYbGameMixN1.mp3")
var songvolume : float = -5.0
var sfxvol : float = -13.0
const N2_S = preload("res://assets/music/HtbSong2-1.mp3")
const HTB_SONG_2_1_SLOW = preload("res://assets/music/HtbSong2-1Slow.mp3")


func startplay(song):
	stream = song
	volume_db = songvolume
	bus = "Music"
	play(0.0)
	
func stopplay():
	stop()
