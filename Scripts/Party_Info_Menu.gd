extends Node

@export var members: Array
var loaded_party: Party

# Called when the node enters the scene tree for the first time.
func _ready():
	members.append($Party_Menu_Block1)
	members.append($Party_Menu_Block2)
	members.append($Party_Menu_Block3)
	members.append($Party_Menu_Block4)
	loaded_party = get_parent().get_parent().get_parent().get_party()
	load_party_data(loaded_party)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_member_hp(member: int, amount: int):
	members[member].change_hp(amount, 100)	

func change_member_def(member: int, amount: int):
	members[member].change_def(amount)

func change_member_atk(member: int, amount: int):
	members[member].change_atk(amount)

func load_party_data(party: Party):
	loaded_party = get_parent().get_parent().get_parent().get_party()
	party = loaded_party
	change_member_atk(0, party.member_0.atk)
	change_member_atk(1, party.member_1.atk)
	change_member_atk(2, party.member_2.atk)
	change_member_atk(3, party.member_3.atk)
	change_member_def(0, party.member_0.def)
	change_member_def(1, party.member_1.def)
	change_member_def(2, party.member_2.def)
	change_member_def(3, party.member_3.def)
	change_member_hp(0, party.member_0.hp)
	change_member_hp(1, party.member_1.hp)
	change_member_hp(2, party.member_2.hp)
	change_member_hp(3, party.member_3.hp)

	
