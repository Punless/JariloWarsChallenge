#Purpose: To create a selection box for selecting units
extends Camera2D

@export var SPEED = 20.0
@export var ZOOM_SPEED = 20.0
@export var ZOOM_MARGIN = 0.1
@export var ZOOM_MIN = 0.5
@export var ZOOM_MAX = 3.0

var zoomFactor = 1.0
var zoomPos = Vector2()
var zooming = false
#intializing variables
var mousePos = Vector2()
var mousePosGlobal = Vector2()
var start = Vector2()
var startV = Vector2()
var end = Vector2()
var endV = Vector2()
var isDragging = false 
signal area_selected 
signal start_move_selection
@onready var box = get_node("../UI/Panel2")

func _ready():
	connect("area_selected",Callable(get_parent(), "_on_area_selected"))

func _process(delta):
	
	#move the camera
	var inputX = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	var inputY = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
	position.x = lerp(position.x,position.x+inputX*SPEED*zoom.x, SPEED*delta)
	position.y = lerp(position.y,position.y+inputY*SPEED*zoom.y, SPEED*delta)
	
	zoom.x = lerp(zoom.x,zoom.x*zoomFactor,ZOOM_SPEED*delta)
	zoom.y = lerp(zoom.y,zoom.y*zoomFactor,ZOOM_SPEED*delta)
	
	zoom.x = clamp(zoom.x, ZOOM_MIN, ZOOM_MAX)
	zoom.y = clamp(zoom.y, ZOOM_MIN, ZOOM_MAX)
	
	if not zooming:
		zoomFactor = 1.0
	#Detects if mouse is held down
	if Input.is_action_just_pressed("LeftClick") and $"../UI/DialogueBox".gameStart: #doesn't allow you to make a box if game not started yet
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
	
	if isDragging:
		end = mousePosGlobal 
		endV = mousePos
		draw_area()
		
	if Input.is_action_just_released("LeftClick"):
		if startV.distance_to(mousePos) > 20:
			end = mousePosGlobal 
			endV = mousePos
			isDragging = false
			draw_area(false)
			emit_signal("area_selected", self)
		else:
			end = start 
			isDragging = false
			draw_area(false)
			
		
func _input(event):
	if abs(zoomPos.x - get_global_mouse_position().x) > ZOOM_MARGIN:
		zoomFactor = 1.0
	if abs(zoomPos.y - get_global_mouse_position().y) > ZOOM_MARGIN:
		zoomFactor = 1.0	
	
	if event is InputEventMouseButton: #Controls the zoom of the game
		if event.is_pressed():
			zooming = true 
			if event.is_action("WheelDown"): 
				zoomFactor -= 0.01 * ZOOM_SPEED
				zoomPos =  get_global_mouse_position()
			if event.is_action("WheelUp"):
				zoomFactor += 0.01 * ZOOM_SPEED
				zoomPos =  get_global_mouse_position()
		else:
			zooming = false
	
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()

#Create the selection box	
func draw_area(s=true):
	
	box.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	box.position = pos
	box.size *= int(s)
	

