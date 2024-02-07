extends Node

var game: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	game = get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play():
	game.change_scene("res://Scenes/Maps/dev_01.tscn", "dev_01")
	game.change_player("res://Scenes/Player/Player.tscn", "Player")

func char_menu():
	game.change_scene("res://Scenes/Party_Info_Menu.tscn", "Party_Info_Menu")
