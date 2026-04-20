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
	if event.is_action_pressed("ui_left") and current_level > 0:
		current_level -= 1
		$PLAYER.global_position = levels[current_level].global_position
	
	if event.is_action_pressed("ui_right") and current_level < levels.size() -1:
		current_level += 1
		$PLAYER.global_position = levels[current_level].global_position
	
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file(LOADEDLEVELS[current_level])
