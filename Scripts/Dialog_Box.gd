extends Control

var cooldown = 0.2
var tween: Tween
var main_text_box: RichTextLabel
var name_text_box: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	main_text_box = $MainTextBox
	name_text_box = $NameTextBox
#	display_dialog("sus", "amogus sus")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown < 0:
		if Input.is_action_just_pressed("ui_accept"):
			hide()
			cooldown = 0.2
			get_tree().paused = false
	
	else:
		cooldown -= delta

		
func display_dialog(name_text, main_text):
	name_text_box.text = name_text
	main_text_box.text = main_text
	tween = create_tween()
	tween.tween_property(main_text_box, "visible_characters", main_text_box.text.length(), 0.2).from(0)
	print("done")
	tween.connect("finished", on_tween_finished)
	
func on_tween_finished():
	print("Tween done!")

