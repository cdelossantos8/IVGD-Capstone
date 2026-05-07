extends State

func enter():
	super.enter()
	owner.set_physics_process(false)
	animation_player.play('death')
	await animation_player.animation_finished
	owner.queue_free()

func exit():
	super.exit()
	
