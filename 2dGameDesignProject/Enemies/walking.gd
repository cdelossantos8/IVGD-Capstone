extends State

func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("walking")

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var gapX = owner.player.global_position.x - owner.global_position.x
	var distance = abs(gapX)
	
	if distance < 400 and owner.get_node("Timer").is_stopped():
		get_parent().change_state("ranged_attack")
