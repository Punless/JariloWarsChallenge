extends Node2D
@onready var choiceButtonScene = preload("res://addons/ChoiceButton.tscn")
var choice_buttons: Array[Button] =[]
var dialogueEnd = false
var seconds = 150
var gameStart = false
var gameEnd = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$"../showTime/Timer".stop()
func _process(delta): #Detects if game ended or not. 
	$"../showTime".text = "Time Left: "+str(seconds)+" seconds"
	if seconds<=0 and !gameEnd:
		if Global.Wood >= 500:
			Global.ending = 3
		else:
			Global.ending = 2
		get_tree().change_scene_to_file("res://Scenes/ending.tscn")
	
func add_text(title: String,cont: String):#Adds text
	$Sprite2D.visible = true
	$VBoxContainer/Title.text = title
	$VBoxContainer/Content.text = cont
	if(dialogueEnd):
		$"../showTime/Timer".start()
		gameStart = true
		clear_dialogue()

func add_choice(choiceString: String):#Adds an box to the Vboxcontainer2
	var obj = choiceButtonScene.instantiate()
	obj.choiceIndex = choice_buttons.size()
	choice_buttons.push_back(obj)
	obj.text = choiceString
	obj.choiceSelected.connect(_on_choice_selected)
	$VBoxContainer/VBoxContainer2.add_child(obj)

func _on_choice_selected(choice_index: int):#Gives you the next dialogue
	if(!dialogueEnd):
		($EzDialogue as EzDialogue).next(choice_index)
	else:
		clear_dialogue()

func clear_dialogue(): #Get rids of current dialogue

	$VBoxContainer/Title.text = "" 
	for choice in choice_buttons:
		$VBoxContainer/VBoxContainer2.remove_child(choice)
	choice_buttons = []
	$Sprite2D.visible = false



func _on_ez_dialogue_end_of_dialogue_reached(): #Checks for end of dialogue

	dialogueEnd = true


func _on_timer_timeout(): #decrement by 1 per second
	seconds -= 1
