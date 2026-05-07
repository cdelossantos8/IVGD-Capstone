extends State

func enter():
	super.enter()
	animation_player.play('attack')
	await animation_player.animation_finished
