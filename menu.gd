extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$RichTextLabel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_options_button_pressed():
	$VBoxContainer.visible = false
	$RichTextLabel.visible = true


func _on_return_button_pressed():
	$VBoxContainer.visible = true
	$RichTextLabel.visible = false
