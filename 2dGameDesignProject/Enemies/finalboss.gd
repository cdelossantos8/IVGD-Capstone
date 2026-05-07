extends CharacterBody2D

@onready var player = $"../../CharacterBody2D"
@onready var sprite = $Sprite2D
var knockbackVelocity = Vector2.ZERO
@export var gravity: float = 900.0
@export var speed = 100
var direction: int


func _ready():
	set_physics_process(false)
	

	
func _physics_process(delta):
	var distanceX = player.position.x - position.x
	direction = sign(distanceX)
	
	
	if direction < 0: 
		sprite.scale.x = 1
	else:
		sprite.scale.x = -1
	
	velocity.x = direction * speed	
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
func transition():
	var distance = owner.direction.length()
	
	if distance < 30:
		get_parent().change_state("attack")
	
