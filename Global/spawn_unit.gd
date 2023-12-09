extends Node2D

@onready var unit = preload("res://Units/MeleeUnit.tscn")
var housePos
#@onready var xPlace = 
#@onready var yPlace = 
func _ready():
	Global.menuOpened = true

func _on_produce_pressed():
	if Global.Wood >= 50:
		var unitPath = get_tree().get_root().get_node("Game/Melee")
		var gamePath = get_tree().get_root().get_node("Game")
		var unit1 = unit.instantiate()
		#unit1.position = Vector2(housePos.x,housePos.y-50)
		unit1.position = Vector2(housePos.x,housePos.y+50)
		print("unit spawned!")
		unitPath.add_child(unit1)
		gamePath.get_units()
		var tween = get_tree().create_tween()
		tween.tween_property(Global, "Wood", Global.Wood-50, .5)
	
func _on_cancel_pressed():
	cancel()
func cancel():
	Global.menuOpened = false
	queue_free()
