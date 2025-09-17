extends RichTextLabel
@export var dialog : DialogComponent

func _ready() -> void:
	if dialog != null:
		dialog.Continued.connect(on_continue)

func on_continue():
	match dialog.linecount:
		0:
			self.visible = false
