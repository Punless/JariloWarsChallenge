extends Node2D
@onready var ending = Global.ending

# Called when the node enters the scene tree for the first time.
func _ready():
	if ending==1:
		$EndingText.text = "Unwilling to face the wrath of the eternal freeze, your troops retreat back to the safe warmth of Belobog. \n NEUTRAL ENDING"
	if ending==2:
		$EndingText.text = "Unable to build the bunker in time, the troops started to freeze. You return back to Belobog, beaten and battered. \nYou will face charges for reckless endangerment of your troops. \n BAD ENDING"
	if ending==3:
		$EndingText.text = "With your bunker fortified, all of your troops successfully fight off the cold of the eternal freeze. \nThe next morning, your troops march forward towards a new future. \n Good Ending"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
