extends Node2D
var units = []
@onready var music1 = get_node("Music/Embers")

func _ready():
	music1.playing = true
	get_units()
	
#game_node.connect("ui_ready", master_script, "on_ui_ready")
	

func get_units():
	units = null
	units = get_tree().get_nodes_in_group("units")
	
func _on_area_selected(object): #pass the properties of the box
	var start = object.start
	var end = object.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var ut = get_units_in_area(area)
	for u in units:
		u.set_selected(false)
	for u in ut:
		u.set_selected(!u.selected)
func get_units_in_area(area): #select all units in an area.
	var u = []
	for unit in units:
		if unit.position.x > area[0].x and unit.position.x < area[1].x:
			if unit.position.y > area[0].y and unit.position.y < area[1].y:
				u.append(unit)
				#checks if a unit is in the X and Y bounds of the rectangle
	return u


func _on_ez_dialogue_dialogue_generated(response):
	$DialogueBox.add_text(response.text, "Gepard")
	for choice in response.choices:
		$DialogueBox.add_choice(choice)
