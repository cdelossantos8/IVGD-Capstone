extends Node2D

@export_multiline var message: String  

func _ready():
	$Label.text = message
	$Label.hide()




func _on_area_2d_body_entered(body: Node2D) -> void:
	$Label.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	$Label.hide()
