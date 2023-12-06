extends Control

var cooldown = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown < 0:
		if Input.is_action_just_pressed("ui_accept"):
			hide()
			cooldown = 0.2
			get_tree().paused = false
	
	else:
		cooldown -= delta
		
