extends Control

@onready var QuitLabel: Label = $VBoxContainer/Quit/HBoxContainer/QuitLabel
@onready var Start: Button = $VBoxContainer/Start
@onready var Quit: Button = $VBoxContainer/Quit

var messageIndex = 0
var messages = [
	"Art thou sure?", 
	
	"THINE PROGRESS WONT SAVE TO DISC!", 
	
	"Coward!", 
	
	"Thou wilt never save Sir John at this point!", 
	
	"Just play the game.", 
	
	"Doth thou really desire to replay everything that thou have done?", 
	
	"Egad!", 
	
	"Just give up on this", 
	
	"I wont let you quit", 
	
	"Take no for an answer!",
	 
	"Its for the good of Sir John!", "*yawn", "Thou could hast played a whole level by now", 
	
	"IT WONT WORK STOP PRESSING ME", 
	
	"AHHHHHHHH"
	]

func ready():
	pass

func _process(float) -> void:
	$Node2D/AnimatedSprite2D.play("default")

func _on_quit_pressed() -> void:
	QuitLabel.text = messages[messageIndex]
	if (messageIndex == messages.size() - 1):
		get_tree().quit()
	messageIndex = (messageIndex + 1) 
	


func _on_start_pressed() -> void:
	var run = create_tween()
	
	run.tween_property($Node2D/AnimatedSprite2D, "position", Vector2(190, 437), .5)
	run.tween_property($Node2D/AnimatedSprite2D, "position", Vector2(1300, 437), 1.5)
	
	await run.finished
	get_tree().change_scene_to_file("res://Levels/LevelResources/levelselect.tscn")
