extends Node

@onready var spawn = preload("res://Global/spawn_unit.tscn")
@onready var ending = 0


var Wood = 50
var menuOpened = false

func _ready():
	pass
	
	


func spawnUnit(pos): #Create the spawn unit node. 
	var ui_node = get_tree().get_root().get_node("Game/UI")	


	var spawnUnit = spawn.instantiate()
	spawnUnit.housePos = pos
	if ui_node != null && !menuOpened:

		ui_node.add_child(spawnUnit)
	else:
		print("UI node not found!")

