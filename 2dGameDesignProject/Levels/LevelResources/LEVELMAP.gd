extends Control

@onready var levels: Array = [$LEVELICON, $LEVELICON2, $LEVELICON3]
@onready var LOADEDLEVELS: Array = [
	'res://Levels/MainLevels/MainLevel1.tscn',
	'res://Levels/SwordLevels/SwordLevel3.tscn',
	'res://Levels/GauntletsLevels/GauntletsLevel3.tscn'
]

var CompletedLevels : Array = []
var isMoving : bool = false
var current_level : int = 0

func _ready() -> void:
	isMoving = true
	var move = create_tween()
	var fade = create_tween()
	
	fade.tween_property($ColorRect, "modulate:a", 0.0, .5)
	move.tween_property($PLAYER, "position", Vector2(levels[current_level].global_position.x,levels[current_level].global_position.y), 1.75)
	
	await move.finished
	isMoving = false
	await fade.finished
	
	
	#$PLAYER.global_position = levels[current_level].global_position

func createCompletedLevels() -> void: 
	pass

func _process(float):
	if isMoving == false:
		$PLAYER/AnimatedSprite2D.play("default")
	else: 
		$PLAYER/AnimatedSprite2D.play("running")

func _input(event):
	var move = create_tween()
	
	if event.is_action_pressed("moveLeft") and current_level > 0:
		current_level -= 1
		isMoving = true
		move.tween_property($PLAYER, "scale:x", -1, 0)
		move.tween_property($PLAYER, "position", Vector2(levels[current_level].global_position.x,levels[current_level].global_position.y), 1)
		
		await move.finished
		isMoving = false
		#$PLAYER.global_position = levels[current_level].global_position
	
	if event.is_action_pressed("moveRight") and current_level < levels.size() -1:
		current_level += 1
		isMoving = true
		move.tween_property($PLAYER, "scale:x", 1, 0)
		move.tween_property($PLAYER, "position", Vector2(levels[current_level].global_position.x,levels[current_level].global_position.y), 1)
		
		await move.finished
		isMoving = false
		#$PLAYER.global_position = levels[current_level].global_position
	
	if event.is_action_pressed("ui_accept") && isMoving == false:
		$PLAYER/AnimatedSprite2D.stop()
		
		var teleport = create_tween()
		move.tween_property($PLAYER, "scale:x", 1, 0)
		teleport.tween_property($PLAYER/AnimatedSprite2D, "modulate", Color.SKY_BLUE, 0)
		teleport.tween_property($PLAYER/BEAM, "scale", Vector2(1, 1.13), 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		
		teleport.tween_property($PLAYER/AnimatedSprite2D, "scale", Vector2(1,0), 0.1)
		teleport.tween_property($PLAYER/BEAM, "scale", Vector2(0,1.13), 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		
		print("TELEPORTED")
		
		await teleport.finished
		
		get_tree().change_scene_to_file(LOADEDLEVELS[current_level])
		
	
