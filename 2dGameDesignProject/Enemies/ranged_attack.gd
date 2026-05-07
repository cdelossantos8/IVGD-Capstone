extends State

const spell = preload('res://Enemies/Spell.tscn')

func enter():
	super.enter()
	owner.get_node("Timer").start()
	owner.set_physics_process(false)
	animation_player.play("ranged_attack")
	var ranged_attack = spell.instantiate()
	get_tree().current_scene.add_child(ranged_attack)
	await animation_player.animation_finished

func exit():
	super.exit()
	owner.set_physics_process(true)

func transition():
	var gapX = owner.player.global_position.x - owner.global_position.x
	var distance = abs(gapX)
	
	if distance > 300:
		get_parent().change_state("walking")
