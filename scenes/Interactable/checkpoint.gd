extends Node2D
class_name Checkpoint

@export var spawnpoint = false

var activated = false


func activate():
	GameManager.current_checkpoint = self
	activated = true
	$AnimationPlayer.play("Activated")

#func _on_area_2d_area_entered(area):
	#if area.get_parent() is Player && !activated:
		#activate()


#func _on_area_2d_area_entered(area):
	#if area.is_in_group("player"):
		#activate()




func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		activate()


