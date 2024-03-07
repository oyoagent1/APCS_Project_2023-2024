extends Node

@export var loaded_scene: Node
@export var loaded_player: Node
@export var party_menu: Node
var enable_player: bool 
@export var party: Party
# The index in the array, NOT the actual partymember
var active_party_member: int
var can_switch_player: bool

# Signals
signal s_party_member_changed(data: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	active_party_member = 0
	can_switch_player = true
	#party = Party.new()
	load_party("res://Resources/dev_party.tres")
	#load the menu
	connect("s_party_member_changed", test1)
	set_active_player(1)
	test1(1)
	change_scene("res://Scenes/Main_Menu.tscn", "Main_Menu")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if Input.is_action_just_pressed("Open Party Menu"):
		display_party_menu(true)

func change_scene(scenepath: String, id: String):
	# Get rid of previos scene
	if loaded_scene.get_child(0) != null:
		loaded_scene.get_child(0).queue_free()
	var new_scene: PackedScene = load(scenepath)
	loaded_scene.add_child(new_scene.instantiate())
	print(loaded_scene, find_child(id))

func disable_player():
	loaded_player.get_child(0).queue_free()

func change_player(scenepath: String, id: String):
	# Get rid of previos scene
	if loaded_player.get_child(0) != null:
		loaded_player.get_child(0).queue_free()
	var new_scene: PackedScene = load(scenepath)
	loaded_player.add_child(new_scene.instantiate())
	print(loaded_player, find_child(id))

func display_party_menu(display: bool):
	# make sure the game isn't already paused and 
	if !party_menu.visible && !get_tree().paused:
		party_menu.show()
		# Refresh Party data
		party_menu.load_party_data(party)
		pause_game()
	elif party_menu.visible:
		party_menu.hide()
		unpause_game()

func get_active_player():
	return party.members[active_party_member]

func set_active_player(player_index:int):
	if (can_switch_player):
		active_party_member = player_index
		s_party_member_changed.emit(1)

func load_party(path):
	party = ResourceLoader.load(path)

func save_party(path):
	ResourceSaver.save(party, path)

func pause_game():
	get_tree().paused = true

func unpause_game():
	get_tree().paused = false

func get_party() -> Party:
	return party

func test1(data:int):
	print(data)
