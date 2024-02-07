extends CharacterBody2D

var facing: Vector2
var move_inputs: Vector2
var sprite: AnimatedSprite2D

@export var speed = 1.0



# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_get_input()
	move(delta, move_inputs)

func _get_input():
	move_inputs.x = Input.get_axis("Move Left ", "Move Right")
	move_inputs.y = Input.get_axis("Move Up", "Move Down")

	if move_inputs.x < 0:
		facing = Vector2(-1,0)
	elif move_inputs.x > 0:
		facing = Vector2(1,0)

	if move_inputs.y < 0:
		facing = Vector2(0,-1)
	elif move_inputs.y > 0:
		facing = Vector2(0,1)

func move(delta, amount: Vector2):
	if amount != Vector2.ZERO:
		move_and_collide(amount * delta * speed)
		if facing.x < 0:
			sprite.play("left")
		elif facing.x > 0:
			sprite.play("right")
		if facing.y > 0:
			sprite.play("down")
		elif facing.y < 0:
			sprite.play("up")
