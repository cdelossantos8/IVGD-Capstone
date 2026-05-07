extends Control

var messageIndex = 0

@export var displayTime: float = 4.0

var messages = [
	' Congrats on defeating the lord of the undead! ',
	
	' Thank you for playing the game! ',
	
	' Special thanks to professor John for a great semester! ',
	
	' and thanks to the 2d game group for the first iteration of this game! ',
	
	' IVGD rocks!!! '
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Node2D/AnimatedSprite2D.play("default")
	$Label.modulate.a = 0
	var fade = create_tween()
	fade.tween_property($ColorRect2, "modulate:a", 0.0, 1)
	await fade.finished
	for text in messages: 
		await revealText(text)
	
	
	var run = create_tween()
	run.tween_property($Node2D/AnimatedSprite2D, 'position', Vector2(180, 428.0), 0.5)
	
	run.tween_property($Node2D/AnimatedSprite2D, 'position', Vector2(1400, 428.0), 1.5)
	await run.finished
	
	var fadeOut = create_tween()
	fadeOut.tween_property($ColorRect2, 'modulate:a', 1.0, 1)
	await fadeOut.finished
	
	get_tree().change_scene_to_file('res://MAINMENU.tscn')
	
	
func revealText(Text: String):
	$Label.text = Text
	var reveal = create_tween()
	reveal.tween_property($Label, "modulate:a", 1.0, 1)
	await reveal.finished
	await get_tree().create_timer(displayTime).timeout
	
	var hide = create_tween()
	hide.tween_property($Label, "modulate:a", 0.0, 1)
	await hide.finished
	
	return
	
	
	
	
