extends Button

var choiceIndex: int

signal choiceSelected(choiceIndex)

func _on_pressed():
	choiceSelected.emit(choiceIndex)
	
