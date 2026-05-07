extends Area2D

var Skeleton: PackedScene = preload('res://Enemies/SummonedSkeleton.tscn')

var canSpawn: bool = true

func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group('player') and canSpawn:
		var Spawn = Skeleton.instantiate()
		Spawn.global_position.x = $CollisionShape2D.global_position.x + 250
		Spawn.global_position.y = $CollisionShape2D.global_position.y - 2
		get_tree().current_scene.add_child(Spawn)
		canSpawn = false
