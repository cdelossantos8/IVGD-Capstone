extends Control

@onready var levels: Array = [$LEVELICON, $LEVELICON2, $LEVELICON3]
@onready var LOADEDLEVELS: Array = [
	'res://Levels/BowLevels/BowLevel1.tscn', 
	"res://Levels/BowLevels/BowLevel2.tscn", 
	"res://Levels/BowLevels/BowLevel3.tscn"
]
var current_level : int = 0

func _ready() -> void:
	$PLAYER.global_position = levels[current_level].global_position

func _process(float):
	$PLAYER/AnimatedSprite2D.play("default")

func _input(event):
	var move = create_tween()
	
	if event.is_action_pressed("ui_left") and current_level > 0:
		current_level -= 1
		move.tween_property($PLAYER, "scale:x", -1, 0)
		move.tween_property($PLAYER, "position", Vector2(levels[current_level].global_position.x,levels[current_level].global_position.y), 1)
		#$PLAYER.global_position = levels[current_level].global_position
	
	if event.is_action_pressed("ui_right") and current_level < levels.size() -1:
		current_level += 1
		move.tween_property($PLAYER, "scale:x", 1, 0)
		move.tween_property($PLAYER, "position", Vector2(levels[current_level].global_position.x,levels[current_level].global_position.y), 1)
		#$PLAYER.global_position = levels[current_level].global_position
	
	if event.is_action_pressed("ui_accept"):
		$PLAYER/AnimatedSprite2D.stop()
		
		var teleport = create_tween()
		move.tween_property($PLAYER, "scale:x", 1, 0)
		teleport.tween_property($PLAYER/AnimatedSprite2D, "modulate", Color.SKY_BLUE, 0)
		teleport.tween_property($PLAYER/BEAM, "scale", Vector2(1,1), 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		
		teleport.tween_property($PLAYER/AnimatedSprite2D, "scale", Vector2(1,0), 0.1)
		teleport.tween_property($PLAYER/BEAM, "scale", Vector2(0,1), 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		
		print("TELEPORTED")
		
		await teleport.finished
		
		get_tree().change_scene_to_file(LOADEDLEVELS[current_level])
		
	
