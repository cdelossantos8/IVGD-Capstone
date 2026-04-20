@tool
extends Control

@export var level_index : int 
@export var loadedLevel : String 
@export var COMPLETED : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Level " + str(level_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$Label.text = "Level " + str(level_index)
	$AnimatedSprite2D.play("default")
	
