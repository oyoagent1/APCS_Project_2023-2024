extends Area2D

var move_inputs: Vector2

@export var tile_size: int = 16
@export var speed = 0.1
var moving: bool = false
var tween: Tween
var ray: RayCast2D
var interaction_ray: RayCast2D
var facing: Vector2
var sprite: AnimatedSprite2D
var dialog_box: Control

enum directions {UP, DOWN, LEFT, RIGHT}


# Called when the node enters the scene tree for the first time.
func _ready():
	ray = $RayCast2D
	interaction_ray = $InteractionRayCast2D
	sprite = $AnimatedSprite2D
	dialog_box = $"UI Layer/Dialog_Box"
	tween = create_tween()

func on_tween_finished():
	moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateRays()
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
	draw_circle(to_local(interaction_ray.position + interaction_ray.target_position), 2, Color.ALICE_BLUE)
func move(amount: Vector2):
	if amount == Vector2.ZERO:
		return
	if !moving:
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
		moving = true
		tween = create_tween().set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(self, "position", new_pos, 0.1)
		tween.connect("finished", on_tween_finished)

func open_dialog():
	dialog_box.show()
	var json
	var file = FileAccess.open("res://Dialog/Pochita.json", FileAccess.READ)
	var content = file.get_as_text()
	json = JSON.parse_string(content)
	dialog_box.display_dialog(json.name, json.text)
	get_tree().paused = true

func interact():
	if interaction_ray.is_colliding():
		open_dialog()

func updateRays():
	ray.position = position
	interaction_ray.position = position
	var new_pos = position + (facing * tile_size)
	interaction_ray.target_position = new_pos - position
