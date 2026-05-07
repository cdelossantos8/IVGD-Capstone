extends State

const summon = preload('res://Enemies/skeleton_enemy.tscn')

func enter():
	super.enter()
	owner.get_node("SummonTimer").start()
	
	animation_player.play('ranged_attack')
	await animation_player.animation_finished
	
	# summon the skeletons to the left and right of the boss
	var summon1 = summon.instantiate()
	summon1.global_position = owner.global_position + 100
	
	var summon2 = summon.instantiate()
	summon2.global_position = owner.global_position.x - 100
	
	get_tree().current_scene.add_child(summon1)
	get_tree().current_scene.add_child(summon2)
	
func exit():
	super.exit()
	
	
