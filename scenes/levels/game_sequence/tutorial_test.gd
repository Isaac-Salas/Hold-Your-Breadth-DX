extends Node2D
@onready var static_body_2d = $"../../StaticBody2D"


@onready var camera_2d = $Camera2D
@export var Tutorial : bool 
@onready var transition : TransitionScene = $"../../Transition"
@onready var animation = $AnimationPlayer
@onready var player : SlimePlayer = $".."
@onready var color_rect = $ColorRect
@onready var dialog : DialogComponent = $"../../StaticBody2D/Hamsterzote/DialogBox"
@onready var frozen = $"../../Boxes/Frozen"
@onready var hamsterzote : ObjectClass = $"../../StaticBody2D/Hamsterzote"
@onready var tooltips : AnimatedSprite2D = $"../Tooltips"
@onready var blink : AnimationPlayer = $"../Tooltips/Blink"
@onready var animp = $AnimationPlayer
@onready var message1 = $"../../RichTextLabel"
@onready var message2 = $"../../RichTextLabel2"



@export var TutorialOverride : bool = false
@onready var mouse : Timer = $"../Tooltips/MOUSE"


func _ready():
	
	if TutorialOverride == false:
		Manager.load_game()
		Tutorial = Manager.Level1_1t
		print(Tutorial)
	
	match Tutorial:
		true:
			color_rect.visible = true
			await player.ready
			player.object_detect.monitorable = false
			player.object_detect.monitoring = false
			player.crosshair.toggleprocess(false)
			player.throwcross.toggleprocess(false)
			player.throwcross.visible = false
			
			
		false:
			await player.ready
			player.crosshair.toggleprocess(true)
			player.throwcross.toggleprocess(true)
			var boxes = frozen.get_children()
			for box : ObjectClass in boxes:
				box.freeze = false
			static_body_2d.queue_free()
			camera_2d.queue_free()
			color_rect.queue_free()
			message1.queue_free()
			message2.queue_free()
			
			
			
			

func _process(delta):
	
	if dialog != null:
		match dialog.linecount:
			3:
				#At least you can't move..
				dialog.show_end = false
				dialog.InputSTOP = true
				if dialog.dumbdone == true:
					tooltips.visible = true
					tooltips.play("Move")
					blink.play("BlinkLoop")
					player.set_physics_process(true)
					if Input.is_action_just_pressed("ui_right"):
						# Hamster moved
						dialog.clearcenter()
			
			4:
				#You CAN Move?!
				
				dialog.show_end = true
				dialog.InputSTOP = false
				dialog.position = Vector2(-78,-50)
				blink.play("Stoping")
				await blink.animation_finished
				tooltips.visible = false
				
				
			6:
				#Bet you can't jump tho!
				dialog.show_end = false
				dialog.InputSTOP = true
				
				if dialog.dumbdone == true:
					tooltips.visible = true
					tooltips.play("Jump")
					blink.play("BlinkLoop")
				
				if player.is_on_floor() != true:
					dialog.clearcenter()
				
			7:
				#WOW
				dialog.show_end = true
				dialog.InputSTOP = false
				blink.play("Stoping")
				await blink.animation_finished
				tooltips.visible = false
			
			8:
				# Well at least you cant aim ...
				dialog.show_end = false
				dialog.InputSTOP = true
				hamsterzote.detector.monitoring = true
				hamsterzote.detector.monitorable = true
				player.object_detect.monitorable = true
				if dialog.dumbdone == true:
					tooltips.visible = true
					tooltips.play("Aim")
					blink.play("BlinkLoop")
					player.crosshair.toggleprocess(true)
					player.throwcross.toggleprocess(true)
					if player.controller == true:
						print("Using controller aim")
						if player.throwcross.visible == true:
							dialog.clearcenter()
							dialog.show_end = true
							dialog.InputSTOP = false
					else:
						player.throwcross.visible = true
						if hamsterzote.indicator.visible == true:
							dialog.clearcenter()
							dialog.show_end = true
							dialog.InputSTOP = false
							print("Using mouse aim")
						
						
			9:
				#YOU CAN?!?!?!?!
				dialog.show_end = true
				dialog.InputSTOP = false
				blink.play("Stoping")
				await blink.animation_finished
				tooltips.visible = false
				
				
			10:
				#But surely you cant pick stuff up...
				hamsterzote.add_to_group("throwable")
				dialog.show_end = false
				dialog.InputSTOP = true
				if player.picking == true:
					
					#print("Passado")
					dialog.clearcenter()
					
					#camera_2d.position.y = position.y - 15
					
				tooltips.visible = true
				tooltips.play("Pick-up")
				blink.play("BlinkLoop")
				
				
			11:
				#PUT ME DOWN!!!
				if player.picking == false:
					dialog.clearcenter()
					dialog.InputSTOP = false
					dialog.show_end = true
				else:
					dialog.position.y = -30
					tooltips.visible = true
					tooltips.play("Throw")
					blink.play("BlinkLoop")
			12:
				hamsterzote.remove_from_group("throwable")
				dialog.position.y = -50
				blink.play("Stoping")
				await blink.animation_finished
				tooltips.visible = false
			
			14:
				player.set_physics_process(false)
				player.sprite.play("Idle")
				player.eyes.play("Idle")
				dialog.InputSTOP = true
				dialog.show_end = false
				if dialog.dumbdone == true:
					animp.play_backwards("FadeOut")
					dialog.clearcenter()
					
					
			15:
				dialog.position.y = -80
				dialog.size = Vector2(312, 50)
				dialog.animated_sprite_2d.scale = Vector2(0.6,0.6)
				dialog.push_font_size(50)
				if camera_2d != null and color_rect != null:
					await animp.animation_finished
					var boxes = frozen.get_children()
					for box : ObjectClass in boxes:
						box.freeze = false
					camera_2d.queue_free()
					animp.play("FadeOut")
					static_body_2d.queue_free()
				await animp.animation_finished
				if dialog.dumbdone:
					dialog.clearcenter()
				
			16:
				hamsterzote.collision_layer = 0
				hamsterzote.collision_mask = 0
				hamsterzote.set_deferred("freeze", true)
				hamsterzote.global_position.x += 10
				dialog.push_font_size(50)
				player.set_physics_process(true)


func _on_transition_opendone():
	if Tutorial == true:
		print("CameraDone")
		player.sprite.play("Idle")
		player.set_physics_process(false)
		camera_2d.enabled = true
		camera_2d.make_current()
		animation.play("FadeOut")


func _on_visible_on_screen_notifier_2d_screen_exited():
	if dialog.linecount == 16:
		Manager.setter("Level1_1t", false)
		Manager.save_game()
		hamsterzote.queue_free()
