extends CharacterBody2D

var collisionBoxes : Array = [$PlayerDetection, $Hitbox, $CollisionShape2D]
@onready var state_machine = $FiniteStateMachine
@onready var player = $"../../CharacterBody2D"
@onready var sprite = $Sprite2D
var spell : PackedScene = preload('res://Enemies/Spell.tscn')
var knockbackVelocity = Vector2.ZERO
@export var gravity: float = 900.0
@export var speed = 100
@export var health : int = 500
var direction: int

func _ready():
	set_physics_process(false)
	
	
func takeDamage(amount: float):
	health -= amount
	
	print("Enemy took ", amount, " damage! Health: ", health)

	if health <= 0:
		die()
	else:
		state_machine.change_state('hurt')
		
func die():
	$PlayerDetection/DetectionArea.set_deferred("disabled", true)
	$Physics.set_deferred("disabled", true)
	$Hitbox/Box.set_deferred("disabled", true)
	state_machine.change_state('death')


func _physics_process(delta):
	var distanceX = player.global_position.x - global_position.x
	var distance = abs(distanceX)
	
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
	

		
	
