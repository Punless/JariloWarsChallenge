extends CanvasLayer


@onready var label = $Label
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #Will change wood varible
	label.text = "Wood: "+str(Global.Wood)
