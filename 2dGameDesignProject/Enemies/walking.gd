extends State

func enter():
	super.enter()
	owner.set_physics_process(true)
	print("walking")
	animation_player.play("walking")

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var gapX = owner.player.global_position.x - owner.global_position.x
	var distance = abs(gapX)
	
	if owner.get_node("SummonTimer").is_stopped():
		get_parent().change_state('summon')
		return

	if distance < 400 and owner.get_node("AttackTimer").is_stopped():
		get_parent().change_state("ranged_attack")
		return
		
	
