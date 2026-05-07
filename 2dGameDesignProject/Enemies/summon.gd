extends State

const summon = preload('res://Enemies/SummonedSkeleton.tscn')

func enter():
	super.enter()
	print("summoning")
	owner.get_node("SummonTimer").start()
	
	animation_player.play('ranged_attack')
	await animation_player.animation_finished
	
	var direction = -sign(owner.sprite.scale.x)
	print(direction)
	
	var summon1 = summon.instantiate()
	summon1.global_position = owner.global_position + Vector2(direction * 100, 0)
	
	var summon2 = summon.instantiate()
	summon2.global_position = owner.global_position + Vector2(direction * 200, 0)
	
	get_tree().current_scene.add_child(summon1)
	get_tree().current_scene.add_child(summon2)
	
	get_parent().change_state("walking")

	
func exit():
	super.exit()
	owner.set_physics_process(true)
	
	
	
