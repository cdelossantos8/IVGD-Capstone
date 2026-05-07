extends State

const spell = preload('res://Enemies/Spell.tscn')
var isAttacking : bool = false

func enter():
	super.enter()
	
	animation_player.play("ranged_attack")
	isAttacking = true
	await animation_player.animation_finished
	isAttacking = false
	
	owner.get_node("Timer").start()
	owner.set_physics_process(false)
	var ranged_attack = spell.instantiate()
	get_tree().current_scene.add_child(ranged_attack)
	

func exit():
	super.exit()
	owner.set_physics_process(true)

func transition():
	var gapX = owner.player.global_position.x - owner.global_position.x
	var distance = abs(gapX)
	
	if distance > 300 and isAttacking == false:
		get_parent().change_state("walking")
