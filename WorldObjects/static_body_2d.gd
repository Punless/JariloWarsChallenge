extends StaticBody2D

var totalTime = 50
var currentTime
var units = 0
var dead = false
@onready var sound = $ChopSound
@onready var bar = $ProgressBar
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	bar.max_value = totalTime
	currentTime = totalTime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bar.value = currentTime
	if currentTime <= 0&&!dead:
		dead = true 
		treeChopped()

func _on_chop_zone_body_entered(body):#more units = more chopp speed
	var path = body.get_node("../")
	if path==get_node("/root/Game/Melee"):
		sound.playing = true
		units+=1
		startChopping()
	#if "Melee" in body.name:


func _on_chop_zone_body_exited(body):#Decrease amount of units thus decreasing chop speed
	var path = body.get_node("../")
	if path==get_node("/root/Game/Melee"):
		units-=1
		if units <= 0:
			timer.stop()
			sound.playing = false

func _on_timer_timeout():#Decrease value of health bar after a certain amount of time
	var chopSpeed = 1*units
	currentTime -= 1*units
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", currentTime, 0.5).set_trans(Tween.TRANS_BOUNCE)
	
func startChopping():

	timer.start()
func treeChopped():#Gives you a random number of wood
	if(dead):
		var rng = RandomNumberGenerator.new()
		var random = rng.randi_range(40, 60)
		var tween = get_tree().create_tween()
		#tween.tween_property(self, "modulate", Color.RED, .1)
		tween.parallel().tween_property(self, "rotation", 1.6, .2).set_trans(Tween.TRANS_SINE)
		tween.parallel().tween_property(Global, "Wood", Global.Wood+random,.5)
		tween.tween_callback(self.queue_free).set_delay(.5)
	

