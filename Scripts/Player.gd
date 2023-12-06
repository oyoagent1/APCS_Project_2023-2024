extends Area2D

var move_inputs: Vector2

@export var tile_size: int = 16
@export var speed = 0.1
var moving: bool = false
var tween: Tween
var ray: RayCast2D
var facing: Vector2
var sprite: AnimatedSprite2D
var dialog_box: Control

enum directions {UP, DOWN, LEFT, RIGHT}


# Called when the node enters the scene tree for the first time.
func _ready():
	ray = $RayCast2D
	sprite = $AnimatedSprite2D
	dialog_box = $"UI Layer/Dialog_Box"
	tween = create_tween()

func on_tween_finished():
	moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ray.position = position
	_get_input()
	move(move_inputs)
	queue_redraw()
#	if ray.is_colliding():
#		print("HIT ", ray.get_collider())
#		print(ray.position, ray.target_position)
	
func _get_input():
	move_inputs.x = Input.get_axis("Move Left ", "Move Right")
	move_inputs.y = Input.get_axis("Move Up", "Move Down")
	if move_inputs.y != 0:
		move_inputs.x = 0

	if move_inputs.x < 0:
		move_inputs.x = -1
		facing = Vector2(-1,0)
	elif move_inputs.x > 0:
		move_inputs.x = 1
		facing = Vector2(1,0)

	if move_inputs.y < 0:
		move_inputs.y = -1
		facing = Vector2(0,-1)
	elif move_inputs.y > 0:
		move_inputs.y = 1
		facing = Vector2(0,1)

	if Input.is_action_just_pressed("ui_accept"):
		interact()
	

func _draw():
	pass
	#draw_line(Vector2.ZERO, Vector2.ZERO + (facing * (tile_size/2)), Color.RED, 4)
	#draw_line(to_local(ray.position), to_local(ray.position + ray.target_position), Color.BLUE, 2)

func move(amount: Vector2):
	if amount == Vector2.ZERO:
		return
	if !moving:
		print(facing)
		if facing.x < 0:
			sprite.play("left")
		elif facing.x > 0:
			sprite.play("right")
		if facing.y > 0:
			sprite.play("down")
		elif facing.y < 0:
			sprite.play("up")
		var new_pos: Vector2
		new_pos = position + (facing * tile_size)
		#Check if position is valid	
		ray.target_position = new_pos - position
		ray.force_raycast_update()
		if (ray.is_colliding()):
			print(ray.get_collider())
			print("COLLISION")
			print(position, new_pos, ray.position, ray.target_position)
			return
		print(position, new_pos)
		moving = true
		tween = create_tween().set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(self, "position", new_pos, 0.1)
		tween.connect("finished", on_tween_finished)

func open_dialog():
	dialog_box.show()
	get_tree().paused = true

func interact():
	open_dialog()	