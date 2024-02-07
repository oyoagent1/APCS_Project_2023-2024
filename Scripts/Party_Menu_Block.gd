extends Node

var hp_label: RichTextLabel
var def_label: RichTextLabel
var atk_label: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	hp_label = $BG/HPLabel
	def_label = $BG/DEFLabel
	atk_label = $BG/ATKLabel
	change_hp(0,0)
	change_def(0)
	change_atk(0)

func change_atk(value: int):
	atk_label.text = str("[left]ATK:[/left][right]", value, "[/right] ")

func change_def(value: int):
	def_label.text = str("[left]DEF:[/left][right]", value, "[/right] ")

func change_hp(value: int, max_value: int):
	hp_label.text = str("[left]HP:[/left][right]", value, "/", max_value, "[/right] ")
