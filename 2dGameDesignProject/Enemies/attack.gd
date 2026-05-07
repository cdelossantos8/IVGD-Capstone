extends State

func enter():
	super.enter()
	animation_player.play('attack')
	await animation_player.animation_finished

func transition():
	var gapX = owner.player.global_position.x - owner.global_position.x
	var distance = abs(gapX)
	
	if distance > 300:
		get_parent().change_state('walking')
