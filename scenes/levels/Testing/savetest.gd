extends Control
@onready var rich_text_label = $RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_save_pressed():
	
	Manager.Level1_2 = true
	Manager.save_game()
	rich_text_label.append_text(str(Manager.save_dict))


func _on_load_pressed():
	rich_text_label.newline()
	rich_text_label.append_text(str("Original LVL1-2:", Manager.Level1_2))
	Manager.load_game()
	rich_text_label.newline()
	rich_text_label.append_text(str("Changed to LVL1-2:", Manager.Level1_2))
