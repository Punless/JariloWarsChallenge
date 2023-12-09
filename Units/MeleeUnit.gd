extends CharacterBody2D

@export var selected = false
@onready var box = get_node("Box")
@onready var voice1 = get_node("Suitation")
@onready var direction = "right"
@onready var rightPressed = false
@onready var target = position
var follow_cursor = false
var Speed = 150
func _ready(): #If spawned, add itself to an array. 
	set_selected(selected)
	add_to_group("units", true)
	target = Vector2(position.x,position.y+30)
func _process(delta):
	pass
func set_selected(value):
	selected = value
	box.visible = value 

	voice1.playing = value

func _on_input_event(viewport, event, shape_idx):
	pass # Replace with function body.

var temp: Vector2
func _input(event):


	if event.is_action_pressed("RightClick"):
		
	
		follow_cursor = true


	if event.is_action_released("RightClick"):

		follow_cursor = false
func _physics_process(delta): #slide to a certain place
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
			if(position.x<target.x): #left or right?
				direction = "left"
			else:
				direction="right"
			#changeDirections(direction)
		else:
			follow_cursor = false
	velocity = position.direction_to(target)* Speed

	
	if position.distance_to(target) > 10:
		move_and_slide()
#
#var wasRight = false
#
#func changeDirections(direct: String): #chacne direction
	#print(wasRight)
	#if wasRight == true:
		#if direct == "left":
			#scale.x = -1
			#wasRight = false
	#if wasRight == false:
		#if direct == "right":
			#scale.x = -1
			#wasRight = true

