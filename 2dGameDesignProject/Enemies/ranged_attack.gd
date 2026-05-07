extends State

const spell = preload('res://Enemies/Spell.tscn')

func enter():
	super.enter()
	print("casting spell")
	animation_player.play("ranged_attack")
	
	await animation_player.animation_finished
	
	owner.get_node("AttackTimer").start()
	owner.set_physics_process(false)
	var ranged_attack = spell.instantiate()
	get_tree().current_scene.add_child(ranged_attack)
	
	get_parent().change_state("walking")

func exit():
	super.exit()
	
	
	
