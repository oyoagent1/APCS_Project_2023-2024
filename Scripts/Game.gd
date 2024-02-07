extends Node

@export var loaded_scene: Node
@export var loaded_player: Node
@export var party_menu: Node
var enable_player: bool 
@export var party: Party
# Called when the node enters the scene tree for the first time.
func _ready():
	#party = Party.new()
	load_party("res://Resources/dev_party.tres")
	#load the menu
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
	if !party_menu.visible:
		party_menu.show()
		party_menu.load_party_data(party)
		pause_game()
	else:
		party_menu.hide()
		unpause_game()

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
