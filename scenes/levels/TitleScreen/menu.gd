extends Node2D

@onready var play_sprite = $PlaySprite
@onready var play = $PlaySprite/Play
@onready var levels_sprite = $LevelsSprite
@onready var levels = $LevelsSprite/Levels
@onready var options_sprite = $OptionsSprite
@onready var options = $OptionsSprite/Options
@onready var quit_sprite = $QuitSprite
@onready var quit = $QuitSprite/Quit
@export var screenstuff : ScreenStuff 
@export var fadeout : AnimationPlayer
@onready var transition: TransitionScene = $Transition
const LEVEL_SELECT = preload("res://scenes/levels/Level_Select/Level_select.tscn")
const INTRO_CUT = preload("res://scenes/cutscenes/IntroAnims/IntroCut.tscn")
const TESTING = preload("res://scenes/levels/Testing/testing.tscn")
const scale_lvl = preload("res://scenes/levels/game_sequence/1-1_Tutorial_throw.tscn")
#const SCENE_SWITCHER = preload("res://scenes/levels/Transition/scene_switcher.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	#Manager.load_data()
	transition.ap.play("Opening")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	if fadeout != null:
		fadeout.play("Fade")
	transition.transition_to(INTRO_CUT)





func _on_play_mouse_entered() -> void:
	play_sprite.play("hover")
	await play_sprite.animation_finished
	play_sprite.play("hover_loop")


func _on_play_mouse_exited() -> void:
	await play_sprite.animation_looped
	play_sprite.play("unhover")
	await play_sprite.animation_finished
	play_sprite.play("normal")


func _on_levels_mouse_entered():
	levels_sprite.play("hover")
	await levels_sprite.animation_finished
	levels_sprite.play("hover_loop")


func _on_levels_mouse_exited():
	await levels_sprite.animation_looped
	levels_sprite.play("unhover")
	await levels_sprite.animation_finished
	levels_sprite.play("normal")


func _on_levels_pressed():
	transition.transition_to(LEVEL_SELECT)


func _on_options_mouse_entered():
	options_sprite.play("hover")
	await options_sprite.animation_finished
	options_sprite.play("hover_loop")


func _on_options_mouse_exited():
	await options_sprite.animation_looped
	options_sprite.play("unhover")
	await options_sprite.animation_finished
	options_sprite.play("normal")


func _on_options_pressed():
	if screenstuff != null:
		var options = screenstuff.options_menu
		options.showtoggle()


func _on_quit_mouse_entered():
	quit_sprite.play("hover")
	await quit_sprite.animation_finished
	quit_sprite.play("hover_loop")



func _on_quit_mouse_exited():
	await quit_sprite.animation_looped
	quit_sprite.play("unhover")
	await quit_sprite.animation_finished
	quit_sprite.play("normal")


func _on_quit_pressed():
	get_tree().quit()
