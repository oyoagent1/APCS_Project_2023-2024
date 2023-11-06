extends Area2D

var move_inputs: Vector2

@export var tile_size: int = 16
@export var speed = 0.1
var moving: bool = false
var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	tween = create_tween()

func on_tween_finished():
	moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_get_input()
	move(move_inputs)

func _get_input():
	move_inputs.x = Input.get_axis("Move Left ", "Move Right")
	move_inputs.y = Input.get_axis("Move Up", "Move Down")
	if move_inputs.y != 0:
		move_inputs.x = 0

	if move_inputs.x < 0:
		move_inputs.x = -1
	if move_inputs.x > 0:
		move_inputs.x = 1
	if move_inputs.y < 0:
		move_inputs.y = -1
	if move_inputs.y > 0:
		move_inputs.y = 1

func move(amount: Vector2):
	if amount == Vector2.ZERO:
		return
	if !moving:
		var new_pos: Vector2
		new_pos = position + amount * tile_size
		print(position, new_pos)
		moving = true
		tween = create_tween().set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(self, "position", new_pos, speed)
		tween.connect("finished", on_tween_finished)
