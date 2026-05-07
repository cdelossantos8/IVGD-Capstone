extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 300.0
@export var health: float = 100.0
@export var speed: float = 150
@export var gravity: float = 900.0
@export var damage : float = 20.0
var direction = 1
# walking cycle variables
@export var max_walk_distance := 50.0
var start = 0
var traveled_distance = 0
@onready var headshot: Area2D = $Headshot
var knockbackVelocity = Vector2.ZERO
@onready var hitbox: Area2D = %Hitbox
@onready var headshot_label: RichTextLabel = $HeadshotLabel
var startingLabelPos : Vector2
var collisionBoxes : Array = [ $PhysicsCollision, $Hitbox/HitboxShape, $Headshot/HeadshotShape]
@onready var physics_collision: CollisionShape2D = $PhysicsCollision
var isKnockedBack : bool = false
@onready var player = get_parent().get_node("CharacterBody2D")

var isRising = true

func _ready():
	headshot_label.visible = false
	startingLabelPos = headshot_label.position
	add_to_group("enemy")
	hitbox.body_entered.connect(onBodyEntered)
	
	await get_tree().process_frame
	anim.play("Rise")
	await anim.animation_finished
	isRising = false

func onBodyEntered(body):
	print("Hit: ", body.name, " | isKnockedBack: ", isKnockedBack, " | inGroup: ", body.is_in_group("enemy"))
	if body.has_method("takeDamage"):
		if body is Player:
			body.takeDamage(damage)
		elif body.is_in_group("enemy") and isKnockedBack:
			disableAllCollsion()
			body.onStyleKill("FRIENDLY FIRE!")
			die()

func _physics_process(delta: float) -> void:
	if isRising == true:
		return
		
	anim.play("Walking")
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var distanceX = player.global_position.x - global_position.x
	var distance = abs(distanceX)
	
	if distance > 1:
		direction = sign(distanceX)
	
	anim.flip_h = direction < 0
		
	velocity.x = speed * direction + knockbackVelocity.x
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	
	move_and_slide()
	
	# decay knockback over time
	knockbackVelocity = knockbackVelocity.move_toward(Vector2.ZERO, 500 * delta)
	if knockbackVelocity.length() < 5.0:
		if isKnockedBack:
			print("Knockback ended, velocity was: ", knockbackVelocity.length())
		isKnockedBack = false
	
	

func applyKnockback(dir: Vector2, force: float):
	knockbackVelocity = dir.normalized() * force
	isKnockedBack = true

func takeDamage(amount: float):
	health -= amount
	print("Enemy took ", amount, " damage! Health: ", health)
	flashRed()
	if health <= 0:
		physics_collision.set_deferred("disabled", true)
		die()


func onStyleKill(label: String = "STYLE KILL!"):
	set_physics_process(false)
	physics_collision.set_deferred("disabled", true)
	disableAllCollsion()
	anim.play("Death")
	headshot_label.text = "[center]" + label + "[/center]"
	headshot_label.position = startingLabelPos
	headshot_label.modulate.a = 1.0
	headshot_label.visible = true
	
	var tween = create_tween().set_parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(headshot_label, ^"position", startingLabelPos + Vector2(2.0, -4.0), 1.4)
	tween.tween_property(headshot_label, ^"modulate:a", 0.0, 1.4)
	flashRed()
	flashRed()
	tween.finished.connect(func():
		headshot_label.visible = false
		ScoreManager.styleKills += 1
		ScoreManager.registerKill()
		queue_free())

func flashRed():
	modulate = Color.RED
	await get_tree().create_timer(0.15).timeout
	modulate = Color.WHITE

func die():
	set_physics_process(false)
	# Disable collisions
	disableAllCollsion()
	anim.play("Death")
	
	# Make it stop walking
	
	# Remove it from the level
	await anim.animation_finished
	queue_free()
	ScoreManager.registerKill()


func disableAllCollsion():
	physics_collision.set_deferred("disabled", true)
	$Hitbox/HitboxShape.set_deferred("disabled", true)
	$Headshot/HeadshotShape.set_deferred("disabled", true)
