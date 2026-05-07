extends CharacterBody2D

@onready var player = $"../../CharacterBody2D"
@onready var sprite = $Sprite2D
var spell : PackedScene = preload('res://Enemies/Spell.tscn')
var knockbackVelocity = Vector2.ZERO
@export var gravity: float = 900.0
@export var speed = 100
var direction: int


func _ready():
	set_physics_process(false)
	

func _physics_process(delta):
	var distanceX = player.global_position.x - global_position.x
	var distance = abs(distanceX)
	print(distance)
	
	if distance > 1:
		direction = sign(distanceX)
	
	if direction < 0: 
		sprite.scale.x = 1
	else:
		sprite.scale.x = -1
		
	velocity.x = direction * speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		
	move_and_slide()
	

		
	
