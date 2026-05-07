extends Area2D

@onready var animated_sprite = $AnimationPlayer
@onready var player = get_parent().find_child("CharacterBody2D")

func _ready():
	global_position.x = player.global_position.x
	global_position.y = player.global_position.y + 40
	animated_sprite.play('spell')
	await animated_sprite.animation_finished
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.takeDamage(50.00)
		
