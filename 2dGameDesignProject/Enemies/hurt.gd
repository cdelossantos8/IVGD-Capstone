extends State

func enter():
	super.enter()
	owner.velocity = Vector2.ZERO
	
	animation_player.play("hurt")
	await animation_player.animation_finished
	
	if get_parent().current_state.name == 'hurt':
		get_parent().change_state("walking")
		
func exit():
	super.exit()
	
